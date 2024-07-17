package com.fjxgwzd.teacherresourcesharing.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.teacherresourcesharing.service.FileService;
import com.fjxgwzd.teacherresourcesharing.vo.BasicInfoVO;
import com.fjxgwzd.teacherresourcesharing.vo.ChapterVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseDetalVO;
import com.fjxgwzd.teacherresourcesharing.vo.schoolMajorList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/files")
public class FileController {
    @Autowired
    private FileService fileService;

    @PostMapping("uploadFile")
    public Result<String> uploadFile(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
//    public Result<String> uploadFile(@RequestParam("file") MultipartFile file, @RequestParam("chapterId") int chapterId, @RequestParam("teacherId") String teacherId) {
        try {
            MultipartFile file = (MultipartFile) conditions.get("file");
            Integer chapterId = (Integer) conditions.get("chapterId");
            String url = fileService.upload(file, chapterId,primaryInfo);
            return Result.ok(url);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @DeleteMapping("/delete")
    public Result<String> deleteFile(@RequestBody Map<String, Object> conditions) {
//    public Result<String> deleteFile(@RequestParam("chapterId") Integer chapter_id) {
        // 在此处的API删除文件，所需上传的主要是该chapter_id，以及由网关传来的用户身份id，我由用户身份id进行课程权限查询
        try {
            Integer chapterId = (Integer) conditions.get("chapterId");
            String result = fileService.deleteFile(chapterId);
            return Result.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    // 返回一门课程的所有信息，包括教材信息
    @PostMapping("/courseDetalInfo")
//    public Result<CourseDetalVO> courseDetailsInfo(@RequestParam("courseInstId") Integer courseInstId) {
    public Result<CourseDetalVO> courseDetailsInfo(@RequestBody Map<String, Object> conditions) {
        // 需要一个信息，即用户传来的chapter_id，我将该课程的所有chapter的信息返回给用户
        try {
            Integer courseInstId = (Integer) conditions.get("courseInstId");
            CourseDetalVO result = fileService.courseDetailsInfo(courseInstId);
            return Result.ok(result);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/chapterDetailInfo")
//    public Result<List<ChapterVO>> chapterDetailInfo(@RequestParam("courseInstId") Integer courseInstId) {
    public Result<List<ChapterVO>> chapterDetailInfo(@RequestBody Map<String, Object> conditions) {
        try {
            Integer courseInstId = (Integer) conditions.get("courseInstId");
            List<ChapterVO> chapterVOList = fileService.chapterList(courseInstId);
            return Result.ok(chapterVOList);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @GetMapping("/school_major")
    public Result<List<schoolMajorList>> getSchoolMajor() {
        try {
            return Result.ok(fileService.getSchoolMajorList());
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    @GetMapping("/basicInfo")
    public Result<BasicInfoVO> getBasicInfo() {
        try {
            return Result.ok(fileService.getBasicInfo());
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail();
        }
    }
}
