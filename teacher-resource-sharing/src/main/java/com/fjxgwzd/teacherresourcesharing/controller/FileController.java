package com.fjxgwzd.teacherresourcesharing.controller;

import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.teacherresourcesharing.service.FileService;
import com.fjxgwzd.teacherresourcesharing.vo.ChapterVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseDetalVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/files")
public class FileController {
    @Autowired
    private FileService fileService;

    @PostMapping("uploadFile")
    public Result<String> uploadFile(@RequestParam("file") MultipartFile file, @RequestParam("chapter_id") int chapterId, @RequestParam("teacher_id") String teacherId) {
        try {
            String url = fileService.upload(file, chapterId,teacherId);
            return Result.ok(url);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @DeleteMapping("/delete")
    public Result<String> deleteFile(@RequestParam("chapter_id") Integer chapter_id) {
        // 在此处的API删除文件，所需上传的主要是该chapter_id，以及由网关传来的用户身份id，我由用户身份id进行课程权限查询
        try {
            String result = fileService.deleteFile(chapter_id);
            return Result.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    // 返回一门课程的所有信息，包括教材信息
    @PostMapping("/courseDetalInfo")
    public Result<CourseDetalVO> courseDetailsInfo(@RequestParam("course_inst_id") Integer courseInstId) {
        // 需要一个信息，即用户传来的chapter_id，我将该课程的所有chapter的信息返回给用户
        try {
            CourseDetalVO result = fileService.courseDetailsInfo(courseInstId);
            return Result.ok(result);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/chapterDetailInfo")
    public Result<List<ChapterVO>> chapterDetailInfo(@RequestParam("course_inst_id") Integer courseInstId) {
        return Result.ok();
    }
}
