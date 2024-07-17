package com.fjxgwzd.academicmanagement.controller;

import com.fjxgwzd.academicmanagement.entity.Campus;
import com.fjxgwzd.academicmanagement.entity.Classroom;
import com.fjxgwzd.academicmanagement.entity.FaultReport;
import com.fjxgwzd.academicmanagement.entity.Teacher;
import com.fjxgwzd.academicmanagement.service.ArchitectureService;
import com.fjxgwzd.academicmanagement.service.FaultService;
import com.fjxgwzd.academicmanagement.service.UserService;
import com.fjxgwzd.common.result.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class FaultController {
    @Autowired
    private FaultService faultService;
    @Autowired
    private ArchitectureService architectureService;
    @Autowired
    private UserService userService;
    @PostMapping("/new_fault_report")
    public Result<Object> fault(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
        Integer classroomId = (Integer) conditions.get("classroomId");
//        String phoneNumber = (String) conditions.get("phoneNumber");
        String faultDesc = (String) conditions.get("faultDesc");
//        Classroom classroom = architectureService.getClassroomById(classroomId);
        Teacher teacher = userService.getTeacherById(primaryInfo);
        FaultReport faultReport = new FaultReport();
        faultReport.setClassroomId(classroomId);
        faultReport.setReporterRole(teacher.getType());
        faultReport.setIdentity(primaryInfo);
        faultReport.setFaultDesc(faultDesc);
        faultReport.setReportTime(new java.util.Date());
        faultReport.setStatus(1);
        if(faultService.insertFaultReport(faultReport))
            return Result.ok();
        else
            return Result.fail();
    }

    @PostMapping("/fault_report")
    public Result<Object> newFault(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
        Map<Integer,String> campusId2Name = new HashMap<>();
        List<Campus> campuses = architectureService.getAllCampuses();
        for (Campus campus : campuses){
            campusId2Name.put(campus.getId(),campus.getName());
        }
        if(!primaryInfo.startsWith("X")){
        Integer status = (Integer) conditions.get("status");
        List<FaultReport> faultReports = faultService.getFaultReportsByStatusAndIdentity(status, primaryInfo);
        Map<String,Object> data = new HashMap<>();
        List<Map<String,Object>> dataValue = new ArrayList<>();
        for(FaultReport faultReport : faultReports){
            Map<String,Object> value = new HashMap<>();
            Classroom classroom = architectureService.getClassroomById(faultReport.getClassroomId());
            value.put("classroomName",classroom.getRoomNumber());
            value.put("faultDesc",faultReport.getFaultDesc());
            value.put("status",faultReport.getStatus());
            value.put("reportTime",faultReport.getReportTime());
            Integer campusId = classroom.getCampusId();
            value.put("campusName",campusId2Name.get(campusId));
            value.put("building",classroom.getBuildingName());
            dataValue.add(value);
        }
        data.put("records",dataValue);
        return Result.ok(data);}
        Integer campusId = (Integer) conditions.get("campusId");
        String building = (String) conditions.get("building");
        Integer offset = (Integer) conditions.get("building");
        Integer num = (Integer) conditions.get("building");
        List<Classroom> classrooms = architectureService.getClassroomByCampusIdAndBuildingName(campusId,building);
        List<Integer> classroomsIds = new ArrayList<>();
        for (Classroom classroom : classrooms){
            classroomsIds.add(classroom.getId());
        }
        List<FaultReport> faultReports = faultService.getFaultReportsByClassroomIds(classroomsIds);
        Map<String,Object> data = new HashMap<>();
        List<Map<String,Object>> dataValue = new ArrayList<>();
        for(int i = offset;i<offset+num && i<faultReports.size();i++){
            FaultReport faultReport = faultReports.get(i);
            Map<String,Object> value = new HashMap<>();
            Classroom classroom = architectureService.getClassroomById(faultReport.getClassroomId());
            value.put("classroomName",classroom.getRoomNumber());
            value.put("faultDesc",faultReport.getFaultDesc());
            value.put("status",faultReport.getStatus());
            value.put("reportTime",faultReport.getReportTime());
            value.put("campusName",campusId2Name.get(campusId));
            value.put("building",classroom.getBuildingName());
            value.put("campusId",campusId);
            value.put("reportId",faultReport.getId());
            value.put("classroomId",classroom.getId());
            dataValue.add(value);
        }

        data.put("records",dataValue);
        data.put("sum",faultReports.size()/num+1);
        return Result.ok(data);
    }

    @PostMapping("/maintainance_record")
    public Result<Object> maintainanceRecord(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
        Integer faultRecordId = (Integer) conditions.get("reportId");
        String maintFrom= (String) conditions.get("maintFrom");
        String maintTo= (String) conditions.get("maintTo");
        String maintDetail= (String) conditions.get("maintDetail");

        System.out.println(faultRecordId);
        System.out.println(maintFrom);
        System.out.println(maintTo);
        System.out.println(maintDetail);
        return Result.ok();
    }


}
