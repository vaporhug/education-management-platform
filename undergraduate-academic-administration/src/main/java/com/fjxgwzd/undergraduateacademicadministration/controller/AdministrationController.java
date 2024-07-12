package com.fjxgwzd.undergraduateacademicadministration.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.undergraduateacademicadministration.service.AdministrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

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

    @GetMapping("/educationPlan")
    public Result<String> educationPlan(@RequestParam("major_id") Short majorId) {
        try {
            String data = administrationService.getEducationPlanByMajorId(majorId);
            return Result.ok(data);
        } catch (JsonProcessingException e) {
            return Result.fail();
        }
    }

}
