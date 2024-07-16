package com.fjxgwzd.teachersystemmanagement.contorller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teachersystemmanagement.service.TeacherService;
import com.fjxgwzd.teachersystemmanagement.vo.*;
import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.vo.TotalStudentDetailVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/TeacherInfo")
public class InfoConrtoller {
    @Autowired
    TeacherService teacherService;

    @PostMapping("/teacherDetails")
    public Result<TeacherDetailInfoVO> teacherDetails(@RequestParam("teacherId") String teacherId) {
        return Result.ok(teacherService.getTeacherDetailInfo(teacherId));
    }

    @PostMapping("/TeacherResearchFindings")
    public Result<TeacherResearchFindings> teacherResearchFindings(@RequestParam("teacherId") String teacherId,@RequestParam("type") Integer type, @RequestParam("offset") Integer offset, @RequestParam("num") Integer num) {
        TeacherResearchFindings teacherResearchFindingsList = teacherService.teacherResearchFindings(teacherId, type, offset, num);
        return Result.ok(teacherResearchFindingsList);
    }

    @PostMapping("/defaultCourseTable")
    public Result<DefaultCourseTableVO> courseTable(@RequestParam("teacherId") String teacherId) {
        try {
            DefaultCourseTableVO defaultCourseTableVO = teacherService.getDefaultCourseTableByTeacherId(teacherId);
            return Result.ok(defaultCourseTableVO);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
//        return Result.ok();
    }

    @PostMapping("/courseTable")
    public Result<List<CourseTaskVO>> CourseTable(@RequestParam("teacherId") String teacherId, @RequestParam("year") Integer year, @RequestParam("termPart") boolean termPart, @RequestParam("week") Integer week) {
//        List<CourseTaskVO> courseTaskVOList = null;
        try {
             List<CourseTaskVO> courseTaskVOList = teacherService.getCourseTaskByTeacherId(teacherId,year,termPart,week);
            return Result.ok(courseTaskVOList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/teacherInfo")
    public Result<TotalTeacherDetailVO> teacherInfo(@RequestParam(required = false) Short schoolId, @RequestParam(required = false) Short majorId, @RequestParam(required = false) String title, @RequestParam(required = false) String name, @RequestParam(required = false) boolean gender, @RequestParam(required = true) Integer offset, @RequestParam(required = true) Integer num) {
        try {
            TotalTeacherDetailVO totalStudentDetailVO = teacherService.getTotalTeacherDetail(schoolId, majorId, title, name,gender,offset,num);
            return Result.ok(totalStudentDetailVO);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }
    @PostMapping("/uploadGrades")
    public Result<String> uploadGrades(@RequestParam String courseInstId,@RequestBody GradeVO[] stuScores){
        return Result.ok(teacherService.uploadGrades(courseInstId, stuScores));
    }
}
