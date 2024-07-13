package com.fjxgwzd.undergraduateacademicadministration.controller;

import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.mapper.StudentIdMapper;
import com.fjxgwzd.undergraduateacademicadministration.service.CourseService;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/studentCourses")
public class CourseController {
    @Autowired
    private CourseService courseService;

    @PostMapping("/coursesInfo")
    public Result<List<CourseInfoVO>> getCourseInfoByStudentId(String studentId, Integer year, boolean termPart){
        List<CourseInfoVO> courseInfoVOList= courseService.getCourseInfoByStudentId(studentId, year, termPart);
        return Result.ok(courseInfoVOList);
    }


}
