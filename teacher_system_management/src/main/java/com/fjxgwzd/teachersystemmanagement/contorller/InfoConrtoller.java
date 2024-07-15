package com.fjxgwzd.teachersystemmanagement.contorller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teachersystemmanagement.service.TeacherService;
import com.fjxgwzd.teachersystemmanagement.vo.CourseTaskVO;
import com.fjxgwzd.teachersystemmanagement.vo.DefaultCourseTableVO;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherResearchFindings;
import com.fjxgwzd.common.result.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherDetailInfoVO;

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
    public Result<TeacherResearchFindings> teacherResearchFindings(@RequestParam("teacherId") String teacherId, @RequestParam("offset") Integer offset, @RequestParam("num") Integer num) {
        TeacherResearchFindings teacherResearchFindingsList = teacherService.teacherResearchFindings(teacherId, offset, num);
        return Result.ok(teacherResearchFindingsList);
    }

    @PostMapping("/defaultCourseTable")
    public Result<DefaultCourseTableVO> courseTable(@RequestParam("teacher_id") String teacherId) {
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
    public Result<List<CourseTaskVO>> CourseTable(@RequestParam("teacher_id") String teacherId, @RequestParam("year") Integer year, @RequestParam("term_part") boolean termPart, @RequestParam("week") Integer week) {
//        List<CourseTaskVO> courseTaskVOList = null;
        try {
             List<CourseTaskVO> courseTaskVOList = teacherService.getCourseTaskByTeacherId(teacherId,year,termPart,week);
            return Result.ok(courseTaskVOList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return Result.fail();
        }
    }
}
