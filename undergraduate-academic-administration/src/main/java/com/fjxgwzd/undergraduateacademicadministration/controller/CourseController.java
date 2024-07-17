package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.mapper.StudentIdMapper;
import com.fjxgwzd.undergraduateacademicadministration.service.CourseService;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseInfoVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseStudentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/studentCourses")
public class CourseController {
    @Autowired
    private CourseService courseService;

    @PostMapping("/coursesInfo")
    public Result<List<CourseInfoVO>> getCourseInfoByStudentId(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions){
//    public Result<List<CourseInfoVO>> getCourseInfoByStudentId(String studentId, Integer year, boolean termPart){
        Integer year = (Integer) conditions.get("year");
        Boolean termPart = (Boolean) conditions.get("termPart");
        List<CourseInfoVO> courseInfoVOList= courseService.getCourseInfoByStudentId(primaryInfo, year, termPart);
        return Result.ok(courseInfoVOList);
    }

    @PostMapping("/getCourseStudent")
    public Result<CourseStudentVO> getCourseStudent(@RequestBody Map<String, Object> conditions){
        try {
            Integer courseInstId = (Integer) conditions.get("courseInstId");
            Integer offset = (Integer) conditions.get("offset");
            Integer num = (Integer) conditions.get("num");
            return Result.ok(courseService.getCourseStudent(courseInstId, offset, num));
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }
}
