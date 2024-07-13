package com.fjxgwd.teachersystemmanagement.contorller;

import com.fjxgwd.teachersystemmanagement.service.TeacherService;
import com.fjxgwd.teachersystemmanagement.vo.TeacherCourseInstVO;
import com.fjxgwd.teachersystemmanagement.vo.TeacherResearchFindings;
import com.fjxgwzd.common.result.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.fjxgwd.teachersystemmanagement.vo.TeacherDetailInfoVO;

import java.util.ArrayList;
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

    @PostMapping("/TeacherCourseDetails")
    public Result<List<TeacherCourseInstVO>> teacherCourseDetails(@RequestParam("teacherId") String teacherId, @RequestParam("year") Integer year, @RequestParam("tearmPart") boolean tearmPart) {
        List<TeacherCourseInstVO> teacherCourseInstVOList = new ArrayList<>();
        return Result.ok(teacherCourseInstVOList);
    }
}
