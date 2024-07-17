package com.fjxgwzd.teacherresourcesharing.controller;

import com.fjxgwzd.teacherresourcesharing.service.CourseService;
import com.fjxgwzd.teacherresourcesharing.service.FileService;
import com.fjxgwzd.teacherresourcesharing.vo.ChapterVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseDetalVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.fjxgwzd.common.result.Result;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/teacherCourses")
public class CourseController {
    @Autowired
    private CourseService courseService;

    // 返回老师所教的所有课程
    @GetMapping("/coursesInfo")
    public Result<List<CourseInfoVO>> coursesInfo(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
//    public Result<List<CourseInfoVO>> coursesInfo(@RequestParam("teacherId") String teacherId, @RequestParam("year") Integer year, @RequestParam("termPart") boolean termPart) {
        // 需要网关将传来的token验证转化为对应的用户id，我将该用户所教授的所有课程信息返回
        try {
            Integer year = (Integer) conditions.get("year");
            boolean termPart = (Boolean) conditions.get("termPart");
            List<CourseInfoVO> result = courseService.coursesInfo(primaryInfo, year, termPart);
            return Result.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail();
        }
    }
}
