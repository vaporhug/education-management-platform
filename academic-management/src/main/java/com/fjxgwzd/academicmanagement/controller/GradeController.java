package com.fjxgwzd.academicmanagement.controller;


import com.fjxgwzd.academicmanagement.entity.CourseInstSection;
import com.fjxgwzd.academicmanagement.entity.CourseSelection;
import com.fjxgwzd.academicmanagement.mapper.GradeMapperForSql;
import com.fjxgwzd.academicmanagement.service.CourseService;
import com.fjxgwzd.academicmanagement.vo.ExamScoreVO;
import com.fjxgwzd.common.result.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class GradeController {
    @Autowired
    GradeMapperForSql gradeMapperForSql;
    @PostMapping("/studentGrades")
    public Result<Object> courseSection(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
        try{
            Boolean termPart = (Boolean) conditions.get("termPart");
            Integer year = (Integer) conditions.get("year");
            List<ExamScoreVO> examScoreVOS = gradeMapperForSql.getExamScoreByStudentId(primaryInfo, year, termPart);
            Map<String,Object> data = Map.of("scores", examScoreVOS);
            return Result.ok(data);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }
}
