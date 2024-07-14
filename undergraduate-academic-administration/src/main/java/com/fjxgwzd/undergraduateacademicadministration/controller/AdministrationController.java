package com.fjxgwzd.undergraduateacademicadministration.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.service.AdministrationService;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseTaskVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.DefaultCourseTableVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.EducationPlanVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.StudentDetailInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/admin")
public class AdministrationController {
    @Autowired
    private AdministrationService administrationService;

    @PostMapping("/attendance")
    public Result<String> attendancerate (@RequestParam("student_id") String studentId) {
        //返回值为每个月的出勤率以及对应月

        return Result.ok();
    }

    @PostMapping("/totalAttendance")
    public Result<String> totalAttendance(@RequestParam("from_mon") LocalDateTime fromMon,@RequestParam("to_mon") LocalDateTime toMon) {
        //返回值为全校学生在某个月的出勤率
        return Result.ok();

    }

    @PostMapping("/studentDetailInfo")
    public Result<StudentDetailInfoVO> studentDetailInfo(@RequestParam("student_id") String studentId) {
        try {
            return Result.ok(administrationService.getStudentDetailInfoByStudentId(studentId));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    @GetMapping("/educationPlanByMajor")
    public Result<EducationPlanVO> educationPlan(@RequestParam("major_id") Short majorId, @RequestParam("cohort_year") Short cohortYear) {
        try {
            EducationPlanVO data = administrationService.getEducationPlanByMajorId(majorId, cohortYear);
            return Result.ok(data);
        } catch (JsonProcessingException e) {
            return Result.fail();
        }
    }

    @PostMapping("/defaultCourseTable")
    public Result<DefaultCourseTableVO> courseTable(@RequestParam("student_id") String studentId) {
        try {
            DefaultCourseTableVO defaultCourseTableVO = administrationService.getDefaultCourseTableByStudentId(studentId);
            return Result.ok(defaultCourseTableVO);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/courseTable")
    public Result<List<CourseTaskVO>> CourseTable(@RequestParam("student_id") String studentId,@RequestParam("year") Integer year, @RequestParam("term_part") boolean termPart, @RequestParam("week") Integer week) {
        List<CourseTaskVO> courseTaskVOList = null;
        try {
            courseTaskVOList = administrationService.getCourseTaskByStudentId(studentId,year,termPart,week);
            return Result.ok(courseTaskVOList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Result.fail();
        }
    }
}
