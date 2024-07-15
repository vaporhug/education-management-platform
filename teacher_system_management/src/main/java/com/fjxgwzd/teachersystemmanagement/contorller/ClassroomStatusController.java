package com.fjxgwzd.teachersystemmanagement.contorller;


import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.teachersystemmanagement.service.ClassroomService;
import com.fjxgwzd.teachersystemmanagement.vo.CampusVO;
import com.fjxgwzd.teachersystemmanagement.vo.ClassroomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Classroom")
public class ClassroomStatusController {
    @Autowired
    ClassroomService classroomService;

    @GetMapping("/getCampusAndBuilding")
    public Result<List<CampusVO>> getCampusAndBuilding(){
        return Result.ok(classroomService.getCampusVO());
    }

    @PostMapping("/getClassroom")
    public Result<List<ClassroomVO>> getClassroom(@RequestParam("campusId") Integer campusId, @RequestParam("building") String building){
        return Result.ok(classroomService.getClassroomVO(campusId,building));
    }

    @PostMapping("/reserveClassroom")
    public Result<String> reserveClassroom(String teacherId,String name,String phoneNumber,Integer campusId,String buildingName,Integer classroomId,Integer year,boolean termPart,Integer week,Integer dayOfWeek,Integer periodFrom,Integer periodTo,Short reason,String reasonDetail){
        return Result.ok(classroomService.reserveClassroom(teacherId,name,phoneNumber, campusId, buildingName, classroomId, year, termPart, week, dayOfWeek, periodFrom, periodTo, reason, reasonDetail));
    }
}
