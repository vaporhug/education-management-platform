package com.fjxgwzd.teachersystemmanagement.contorller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teachersystemmanagement.service.TeacherService;
import com.fjxgwzd.teachersystemmanagement.vo.*;
import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalStudentDetailVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/TeacherInfo")
public class InfoConrtoller {
    @Autowired
    TeacherService teacherService;

    @PostMapping("/teacherDetails")
//    public Result<TeacherDetailInfoVO> teacherDetails(@RequestParam("teacherId") String teacherId) {
    public Result<TeacherDetailInfoVO> teacherDetails(@RequestHeader("PrimaryInfo") String primaryInfo) {
        return Result.ok(teacherService.getTeacherDetailInfo(primaryInfo));
    }

    @PostMapping("/TeacherResearchFindings")
    public Result<TeacherResearchFindings> teacherResearchFindings(@RequestHeader("PrimaryInfo") String primaryInfo,  @RequestBody Map<String, Object> condition) {
//    public Result<TeacherResearchFindings> teacherResearchFindings(@RequestParam("teacherId") String teacherId,@RequestParam("type") Integer type, @RequestParam("offset") Integer offset, @RequestParam("num") Integer num) {
        Integer type = (Integer) condition.get("type");
        Integer offset = (Integer) condition.get("offset");
        Integer num = (Integer) condition.get("num");
        TeacherResearchFindings teacherResearchFindingsList = teacherService.teacherResearchFindings(primaryInfo, type, offset, num);
        return Result.ok(teacherResearchFindingsList);
    }

    @PostMapping("/defaultCourseTable")
//    public Result<DefaultCourseTableVO> courseTable(@RequestParam("teacherId") String teacherId) {
    public Result<DefaultCourseTableVO> courseTable(@RequestParam("PrimaryInfo") String primaryInfo) {
        try {
            DefaultCourseTableVO defaultCourseTableVO = teacherService.getDefaultCourseTableByTeacherId(primaryInfo);
            return Result.ok(defaultCourseTableVO);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
//        return Result.ok();
    }

    @PostMapping("/courseTable")
    public Result<List<CourseTaskVO>> CourseTable(@RequestHeader("PrimaryInfo") String primaryInfo,  @RequestBody Map<String, Object> condition) {
//    public Result<List<CourseTaskVO>> CourseTable(@RequestParam("teacherId") String teacherId, @RequestParam("year") Integer year, @RequestParam("termPart") boolean termPart, @RequestParam("week") Integer week) {
//        List<CourseTaskVO> courseTaskVOList = null;
        try {
            Integer year = (Integer) condition.get("year");
            Boolean termPart = (Boolean) condition.get("termPart");
            Integer week = (Integer) condition.get("week");
             List<CourseTaskVO> courseTaskVOList = teacherService.getCourseTaskByTeacherId(primaryInfo,year,termPart,week);
            return Result.ok(courseTaskVOList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/teacherInfo")
    public Result<TotalTeacherDetailVO> teacherInfo(@RequestBody Map<String, Object> condition) {
//    public Result<TotalTeacherDetailVO> teacherInfo(@RequestParam(required = false) Short schoolId, @RequestParam(required = false) Short majorId, @RequestParam(required = false) String title, @RequestParam(required = false) String name, @RequestParam(required = false) Boolean gender, @RequestParam(required = true) Integer offset, @RequestParam(required = true) Integer num) {
        try {
            Short schoolId = condition.containsKey("schoolId") ? ((Number) condition.get("schoolId")).shortValue() : null;
            Short majorId = condition.containsKey("majorId") ? ((Number) condition.get("majorId")).shortValue() : null;
            String title = (String) condition.get("title");
            String name = (String) condition.get("name");
            Boolean gender = (Boolean) condition.get("gender");
            Integer offset = (Integer) condition.get("offset");
            Integer num = (Integer) condition.get("num");

            TotalTeacherDetailVO totalStudentDetailVO = teacherService.getTotalTeacherDetail(schoolId, majorId, title, name,gender,offset,num);
            return Result.ok(totalStudentDetailVO);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }
    @PostMapping("/uploadGrades")
//    public Result<String> uploadGrades(@RequestParam String courseInstId,@RequestBody GradeVO[] stuScores){
    public Result<String> uploadGrades(@RequestBody Map<String, Object> condition){
        String courseInstId = (String) condition.get("courseInstId");
        GradeVO[] stuScores = (GradeVO[]) condition.get("stuScores");
        return Result.ok(teacherService.uploadGrades(courseInstId, stuScores));
    }
}
