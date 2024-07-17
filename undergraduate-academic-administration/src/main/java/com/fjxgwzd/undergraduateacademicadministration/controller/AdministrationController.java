package com.fjxgwzd.undergraduateacademicadministration.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.service.AdministrationService;
import com.fjxgwzd.undergraduateacademicadministration.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdministrationController {
    @Autowired
    private AdministrationService administrationService;

    @PostMapping("/attendance")
    public Result<String> attendancerate (@RequestParam("studentId") String studentId) {
        //返回值为每个月的出勤率以及对应月

        return Result.ok();
    }

    @PostMapping("/totalAttendance")
    public Result<String> totalAttendance(@RequestParam("fromMon") LocalDateTime fromMon,@RequestParam("toMon") LocalDateTime toMon) {
        //返回值为全校学生在某个月的出勤率
        return Result.ok();

    }

    @PostMapping("/studentDetailInfo")
    public Result<StudentDetailInfoVO> studentDetailInfo(@RequestHeader("PrimaryInfo") String primaryInfo) {
//    public Result<StudentDetailInfoVO> studentDetailInfo(@RequestParam("studentId") String studentId) {
        try {
            return Result.ok(administrationService.getStudentDetailInfoByStudentId(primaryInfo));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    @GetMapping("/educationPlanByMajor")
    public Result<EducationPlanVO> educationPlan(@RequestBody Map<String, Object> conditions) {
//    public Result<EducationPlanVO> educationPlan(@RequestParam("majorId") Short majorId, @RequestParam("cohortYear") Short cohortYear) {
        try {
            Short majorId = Short.valueOf(String.valueOf(conditions.get("majorId")));
            Short cohortYear = Short.valueOf(String.valueOf(conditions.get("cohortYear")));
            EducationPlanVO data = administrationService.getEducationPlanByMajorId(majorId, cohortYear);
            return Result.ok(data);
        } catch (JsonProcessingException e) {
            return Result.fail();
        }
    }

    @PostMapping("/defaultCourseTable")
    public Result<DefaultCourseTableVO> courseTable(@RequestHeader("PrimaryInfo") String primaryInfo) {
        try {
            DefaultCourseTableVO defaultCourseTableVO = administrationService.getDefaultCourseTableByStudentId(primaryInfo);
            return Result.ok(defaultCourseTableVO);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/courseTable")
    public Result<List<CourseTaskVO>> CourseTable(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
//    public Result<List<CourseTaskVO>> CourseTable(@RequestParam("studentId") String studentId,@RequestParam("year") Integer year, @RequestParam("termPart") boolean termPart, @RequestParam("week") Integer week) {
        List<CourseTaskVO> courseTaskVOList = null;
        try {
            Integer year = Integer.valueOf(String.valueOf(conditions.get("year")));
            Boolean termPart = Boolean.valueOf(String.valueOf(conditions.get("termPart")));
            Integer week = Integer.valueOf(String.valueOf(conditions.get("week")));
            courseTaskVOList = administrationService.getCourseTaskByStudentId(primaryInfo,year,termPart,week);
            return Result.ok(courseTaskVOList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/studentInfo")
    public Result<TotalStudentDetailVO> studentInfo(@RequestBody Map<String, Object> conditions) {
//    public Result<TotalStudentDetailVO> studentInfo(@RequestParam(required = false) Short schoolId, @RequestParam(required = false) Short majorId, @RequestParam(required = false) Integer startYear, @RequestParam(required = false) Integer classId, @RequestParam(required = false) Boolean gender, @RequestParam(required = false) String name, @RequestParam(required = true) Integer offset, @RequestParam(required = true) Integer num) {
        try {
            Short schoolId = conditions.containsKey("schoolId") ? ((Number) conditions.get("schoolId")).shortValue() : null;
            Short majorId = conditions.containsKey("majorId") ? ((Number) conditions.get("majorId")).shortValue() : null;
            Integer startYear = (Integer) conditions.get("startYear");
            String name = (String) conditions.get("name");
            Boolean gender = (Boolean) conditions.get("gender");
            Integer offset = (Integer) conditions.get("offset");
            Integer num = (Integer) conditions.get("num");
            Integer classId = (Integer) conditions.get("classId");
            TotalStudentDetailVO totalStudentDetailVO = administrationService.getTotalStudentDetail(schoolId,majorId,startYear,classId,gender,name,offset,num);
            return Result.ok(totalStudentDetailVO);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }
}
