package com.fjxgwzd.teacherresourcesharing.controller;

import com.fjxgwzd.teacherresourcesharing.result.Result;
import com.fjxgwzd.teacherresourcesharing.service.CourseService;
import com.fjxgwzd.teacherresourcesharing.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/courses")
public class CourseController {
    @Autowired
    private CourseService courseService;

    // 返回老师所教的所有课程
    @GetMapping("/coursesInfo")
    public Result<String> coursesInfo(@RequestParam("teacher_id") String teacherId) {
        // 需要网关将传来的token验证转化为对应的用户id，我将该用户所教授的所有课程信息返回
        try {
            courseService.coursesInfo(teacherId);
            return Result.ok();
        }catch (Exception e){
            return Result.fail();
        }
    }

    // 返回一门课程的所有教材信息
    @PostMapping("/courseDetalInfo")
    public Result<String> filesInfo(@RequestParam("course_inst_id") int courseInstId) {
        // 需要一个信息，即用户传来的chapter_id，我将该课程的所有chapter的信息返回给用户
        try {
            courseService.courseDetailsInfo(courseInstId);
            return Result.ok();
        }catch (Exception e){
            return Result.fail();
        }
    }
}
