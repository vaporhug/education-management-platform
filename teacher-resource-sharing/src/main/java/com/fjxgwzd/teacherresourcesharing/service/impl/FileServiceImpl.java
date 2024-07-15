package com.fjxgwzd.teacherresourcesharing.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teacherresourcesharing.entity.CourseInst;
import com.fjxgwzd.teacherresourcesharing.entity.File;
import com.fjxgwzd.teacherresourcesharing.entity.TeachingMaterial;
import com.fjxgwzd.teacherresourcesharing.mapper.ChapterMapper;
import com.fjxgwzd.teacherresourcesharing.minio.MinioProperties;
import com.fjxgwzd.teacherresourcesharing.service.FileService;
import com.fjxgwzd.teacherresourcesharing.vo.ChapterVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseDetalVO;
import com.fjxgwzd.teacherresourcesharing.vo.MaterialVO;
import io.minio.*;
import io.minio.errors.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigInteger;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@EnableConfigurationProperties(MinioProperties.class)
public class FileServiceImpl implements FileService {
    @Autowired
    private MinioClient minioClient;
    @Autowired
    private MinioProperties properties;
    @Autowired
    private ChapterMapper chapterMapper;


    @Override
    public String upload(MultipartFile file, Integer chapterId, String uploaderId) throws Exception {
        String hash = calculateHash(file);
        if(chapterMapper.findByHash(hash)){
            throw new Exception();
        }
//        chapterMapper.findByHash(hash);

        // bucket统一使用一个名字，之后使用/进行课程之间教材的区分
        boolean bucketExists = minioClient.bucketExists(BucketExistsArgs.builder().bucket(properties.getBucketName()).build());
        if (!bucketExists) {
            minioClient.makeBucket(MakeBucketArgs.builder().bucket(properties.getBucketName()).build());
            minioClient.setBucketPolicy(SetBucketPolicyArgs.builder().bucket(properties.getBucketName()).config(createBucketPolicyConfig(properties.getBucketName())).build());
        }

        String fileName = chapterMapper.findCourseIdByChapterId(chapterId) + "/" + file.getOriginalFilename();
        minioClient.putObject(PutObjectArgs.builder().bucket(properties.getBucketName()).stream(file.getInputStream(), file.getSize(), -1).object(fileName).contentType(file.getContentType()).build());

        String url = properties.getEndpoint()+ "/" + properties.getBucketName()+"/"+fileName;
        // 将chapter和file进行存储
        Map<String, Object> params = new HashMap<>();
        params.put("url", url);
        params.put("size", file.getSize());
        params.put("hash", hash);
        chapterMapper.insertFileDetails(params);
        BigInteger generatedId = (BigInteger) params.get("id");
        if(generatedId == null){
            throw new Exception();
        }
        Map<String, Object> paramsMap = new HashMap<>();
        System.out.println(chapterId);
        paramsMap.put("fileId", generatedId);
        paramsMap.put("chapterId", chapterId);
        // 好像查错了，应该查的id是文件的id，要根据chapter的id号查到对应的id
        Integer id = chapterMapper.teacherMaterialId(paramsMap);
        System.out.println(id);
        Map<String, Object> teachingMaterial = new HashMap<>();
        teachingMaterial.put("uploaderId", uploaderId);
        teachingMaterial.put("name", file.getOriginalFilename());
        teachingMaterial.put("fileId",generatedId);
        System.out.println(chapterId);
        teachingMaterial.put("forChapter",String.valueOf(chapterId));
        teachingMaterial.put("uploadTime", LocalDateTime.now());
        chapterMapper.insertTeachingMaterial(teachingMaterial);
        return url;
    }

    // 设置bucket访问权限
    private String createBucketPolicyConfig(String bucketName){
        return """
                {
                   "Statement" : [ {
                     "Action" : "s3:GetObject",
                     "Effect" : "Allow",
                     "Principal" : "*",
                     "Resource" : "arn:aws:s3:::&s/*"
                     } ],
                     "Version" : "2012-10-17"
                }
                """.formatted(bucketName);
    }

    //计算哈希值
    private String calculateHash(MultipartFile file) throws IOException, NoSuchAlgorithmException {
        // 获取哈希算法的一个实例
        MessageDigest digest = MessageDigest.getInstance("SHA-256");

        byte[] bytes = digest.digest(file.getBytes());

        StringBuilder sb = new StringBuilder();
        for(byte b : bytes){
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }


    @Override
    public String deleteFile(Integer chapterId) throws Exception {
        // 待定检测是否需要验证请求删除人具有该权限
        // 1、根据传来的chapterId，找到对应的file文件中的url和所有相关信息
        File file = chapterMapper.getFileByChapterId(chapterId);
        // 2、根据url访问minio，将minio中对应的内容删除掉
        URL url = new URL(file.getUrl());
        String bucketName = url.getPath().split("/")[1];
        String objectName = url.getPath().substring(url.getPath().indexOf("/", 1));
        minioClient.removeObject(RemoveObjectArgs.builder().bucket(bucketName).object(objectName).build());
        // 3、清空对应记录
        // 3.1、首先清除teaching_material
        boolean status = chapterMapper.removeTeachingMaterialByChapterId(chapterId);
        if(!status){
            throw new Exception();
        }
        // 3.2、清除file文件的内容
        status = chapterMapper.removeFileByFileId(file.getId());
        if(!status){
            throw new Exception();
        }
        // 3.3、chapter_id暂时保留，不动
        return "成功删除！";
    }


    @Override
    public CourseDetalVO courseDetailsInfo(Integer courseInstId) throws JsonProcessingException {
//        //  通过courseId查询到所有对应的信息，存储在courseVO当中
        CourseDetalVO courseDetalByCourseInstId = chapterMapper.findCourseDetalByCourseInstId(courseInstId);
        return courseDetalByCourseInstId;
//        CourseDetalVO courseDetalVO = chapterMapper.findCourseBasicDetailByChapterId(courseInstId);
//        List<ChapterVO> chapterVOList = chapterMapper.findChapterByCourseId(courseInstId);
//        List<MaterialVO> chapterMaterialList = chapterMapper.findMaterialByCourseId(courseInstId);
//        for(ChapterVO chapterVO : chapterVOList){
//            for(MaterialVO materialVO : chapterMaterialList){
//                chapterVO.getMatetials().add(materialVO);
//            }
//        }
//        courseDetalVO.
//    }
//        CourseDetalVO courseDetalVO = new CourseDetalVO();
//        return courseDetalVO;
    }

    @Override
    public List<ChapterVO> chapterList(Integer courseInstId) throws JsonProcessingException {

        return List.of();
    }
}
