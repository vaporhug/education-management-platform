package com.fjxgwzd.teacherresourcesharing.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teacherresourcesharing.entity.File;
import com.fjxgwzd.teacherresourcesharing.entity.Semester;
import com.fjxgwzd.teacherresourcesharing.mapper.ChapterMapper;
import com.fjxgwzd.teacherresourcesharing.minio.MinioProperties;
import com.fjxgwzd.teacherresourcesharing.service.FileService;
import com.fjxgwzd.teacherresourcesharing.vo.*;
import io.minio.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigInteger;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.chrono.ChronoLocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
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
//        CourseDetalVO courseDetalByCourseInstId = chapterMapper.findCourseDetalByCourseInstId(courseInstId);
//        return courseDetalByCourseInstId;
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
        // 1、正常获取课程其余信息
        CourseDetalVO courseDetalVO = chapterMapper.findCourseBasicDetailByChapterId(courseInstId);
        courseDetalVO.setCourseCate(changeCourseCate(courseDetalVO.getCourseCate()));
        courseDetalVO.setCourseType(changeCourseType(courseDetalVO.getCourseType()));
        courseDetalVO.setCourseFor(changeCourseFor(courseDetalVO.getCourseFor()));
        // 2、调用以下方法，实现获取课程file信息
        List<Chapter1List> chapter1Lists = new ArrayList<>();
        // 此时返回的内容是所有的父节点
        List<ChapterVO> chapterVOList = chapterMapper.findParentChapter(courseInstId);

        for(ChapterVO chapterVO : chapterVOList){
            // 通过其父节点获取对应的chapter
            List<ChapterVO> materialVOList = chapterMapper.findMaterialByCourseIdParent(courseInstId,chapterVO.getChapter2Id());
//            chapterVO.setMaterials(materialVOList);
            // 有了chapter_2_list，向其中添加
            Chapter1List chapter1List = new Chapter1List();
            chapter1List.setChapter1Id(chapterVO.getChapter2Id());
            chapter1List.setChapter1Name(chapterVO.getChapter2Name());
            chapter1List.setChapter2List(materialVOList);
            chapter1Lists.add(chapter1List);
        }

        courseDetalVO.setChapterList(chapter1Lists);
        return courseDetalVO;
    }

    @Override
    public List<Chapter1List> chapterList(Integer courseInstId) throws JsonProcessingException {
        // 首先获取所有的chapter
        // 1.1、获取所有一级父目录
//        List<ChapterVO> chapterVOList = chapterMapper.findParentChapter(courseInstId);
//
//        // 1.2、将chapter的对应的parent关系，获取对应所有的材料
//        for(ChapterVO chapterVO : chapterVOList){
//            // 通过其父节点获取对应的材料的List
//            List<MaterialVO> materialVOList = chapterMapper.findMaterialByCourseIdParent(courseInstId,chapterVO.getChapterId());
//            chapterVO.setMaterials(materialVOList);
//        }
//        return chapterVOList;
        List<Chapter1List> chapter1Lists = new ArrayList<>();
        // 此时返回的内容是所有的父节点
        List<ChapterVO> chapterVOList = chapterMapper.findParentChapter(courseInstId);

        for(ChapterVO chapterVO : chapterVOList){
            // 通过其父节点获取对应的chapter
            List<ChapterVO> materialVOList = chapterMapper.findMaterialByCourseIdParent(courseInstId,chapterVO.getChapter2Id());
//            chapterVO.setMaterials(materialVOList);
            // 有了chapter_2_list，向其中添加
            Chapter1List chapter1List = new Chapter1List();
            chapter1List.setChapter1Id(chapterVO.getChapter2Id());
            chapter1List.setChapter1Name(chapterVO.getChapter2Name());
            chapter1List.setChapter2List(materialVOList);
            chapter1Lists.add(chapter1List);
        }
        return chapter1Lists;
    }

    public String changeCourseType(String schoolId) {
        Map<String, String> CourseTypeMap = new HashMap<>();
        CourseTypeMap.put("1", "全校性选修课");
        CourseTypeMap.put("2", "专业必修课");
        CourseTypeMap.put("3", "专业选修课");
        String CourseTypeDescription = CourseTypeMap.getOrDefault(schoolId, "未知课程类型");
        return CourseTypeDescription;
    }

    public String changeCourseCate(String schoolId) {
        Map<String, String> CourseCateMap = new HashMap<>();
        CourseCateMap.put("1", "自然科学类");
        CourseCateMap.put("2", "人文社科类");
        CourseCateMap.put("3", "艺术类");
        CourseCateMap.put("4", "体育类");
        CourseCateMap.put("5", "科研实践类");
        String CourseCateDescription = CourseCateMap.getOrDefault(schoolId, "未知课程类型");
        return CourseCateDescription;
    }

    public String changeCourseFor(String schoolId) {
        Map<String, String> CourseForMap = new HashMap<>();
        CourseForMap.put("1", "软件工程");
        CourseForMap.put("2", "计算机科学与技术");
        CourseForMap.put("3", "信息安全");
        CourseForMap.put("4", "人工智能");
        CourseForMap.put("5", "物联网");
        String CourseForDescription = CourseForMap.getOrDefault(schoolId, "未知专业类型");
        return CourseForDescription;
    }

    @Override
    public List<schoolMajorList> getSchoolMajorList() throws JsonProcessingException {
        List<schoolMajorList> schoolMajorListList = chapterMapper.getSchool();
        for(schoolMajorList school : schoolMajorListList){
            school.setMajors(chapterMapper.getMajorList(school.getSchoolId()));
        }
        return schoolMajorListList;
    }

    @Override
    public BasicInfoVO getBasicInfo() throws Exception {
        // 1、根据LocalDateTime获取当前学期
        LocalDateTime currentTime = LocalDateTime.now();
        LocalDate currentDate = currentTime.toLocalDate();
        // 1.1、由年份先判断应该是哪个学期
        Integer currentYear = currentDate.getYear();
        List<Semester> semesters = List.of();
        List<Semester> semesterList = chapterMapper.getAllSemester();
        for (Semester semester : semesterList) {
            if (semester.getYear() == currentYear) {
                semesters.add(semester);
            }
        }
        // 1.2、根据当前时间，获取学期
        // 2、将当前学期的起始周获取，计算当前week
        int week = 1;

        Semester currentSemester = null;
        if(currentDate.isBefore(ChronoLocalDate.from(semesterList.get(0).getFrom_date()))){
            // 小于第一个
            currentSemester = semesterList.get(0);
            week = 1;
        }
        else if (currentDate.isBefore(ChronoLocalDate.from(semesterList.get(1).getTo_date()))){
            currentSemester = semesterList.get(1);
            if(currentDate.isBefore(ChronoLocalDate.from(semesterList.get(1).getTo_date()))){
                week = 1;
            }else {
                week = getWeekNumber(LocalDate.from(currentSemester.getFrom_date()),currentDate);
            }
        }else {
            for(int i =0; i < semesterList.size(); i++){
                if(semesterList.get(i).equals(semesterList.get(1))){
                    if(i+1 < semesterList.size()){
                        currentSemester = semesterList.get(i+1);
                        week = 1;
                        break;
                    }else {
                        throw new Exception();
                    }
                }
            }
        }

        BasicInfoVO basicInfoVO = new BasicInfoVO();
        basicInfoVO.setNowWeek(week);
        basicInfoVO.setNowTermPart(currentSemester.isTerm_part());
        List<schoolMajorList> schoolMajorListList = getSchoolMajorList();
        basicInfoVO.setSchoolMajorList(schoolMajorListList);
        List<CampusVO> campusVOList = chapterMapper.getCampusVO();
        basicInfoVO.setCampusVOList(campusVOList);
        System.out.println(semesterList.get(0).getYear());
        basicInfoVO.setEarliestTermYear(semesterList.get(0).getYear());
        basicInfoVO.setEarliestTermPart(currentSemester.isTerm_part());

        return basicInfoVO;
    }

    public int getWeekNumber(LocalDate startDate, LocalDate endDate) {
        // 计算从起始日期到当前日期的天数
        long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
        // 计算周数
        int weekNumber = (int) (daysBetween / 7) + 1; // +1 是因为第1天就算第1周

        return weekNumber;
    }
}
