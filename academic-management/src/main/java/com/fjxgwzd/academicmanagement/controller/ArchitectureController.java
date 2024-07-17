package com.fjxgwzd.academicmanagement.controller;

import com.fjxgwzd.academicmanagement.entity.Campus;
import com.fjxgwzd.academicmanagement.entity.Classroom;
import com.fjxgwzd.academicmanagement.entity.ClassroomReservation;
import com.fjxgwzd.academicmanagement.entity.ClassroomStatus;
import com.fjxgwzd.academicmanagement.service.ArchitectureService;
import com.fjxgwzd.common.result.Result;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ArchitectureController {

    @Autowired
    private ArchitectureService architectureService;

    @GetMapping(value = "/buildings", consumes = "application/json")
    public Result<Object> getBuilding(@RequestBody(required = false) Map<String, Object> conditions) {

        try {
            Map<String,Object> data = new HashMap<>();
            if (conditions == null) {
                List<Campus> campuses = architectureService.getAllCampuses();
                Map<String,Object> campusBuildings;
                Map<Integer,List<String>> campus2Buildings = new HashMap<>();
                List<Map<String,Object>> campusBuildingValues = new ArrayList<>();
                for (Campus campus : campuses) {
                    campusBuildings = new HashMap<>();
                    campusBuildings.put("campusId",campus.getId());
                    campusBuildings.put("campusName",campus.getName());
                    campusBuildings.put("buildings",new ArrayList<>());
                    campus2Buildings.put(campus.getId(),new ArrayList<>());
                    campusBuildingValues.add(campusBuildings);
                }
                Map<Integer, String> buildings = architectureService.getAllBuildings();
                for (Map.Entry<Integer, String> building : buildings.entrySet()) {
                    campus2Buildings.get(building.getKey()).add(building.getValue());
                }
                for (Map<String,Object> campusBuilding : campusBuildingValues){
                    campusBuilding.put("buildings",campus2Buildings.get((Integer)campusBuilding.get("campusId")));
                }
                data.put("campusBuilding",campusBuildingValues);

            } else {
                Integer campusId = (Integer) conditions.get("campusId");
                List<Classroom> classrooms = architectureService.getClassroomByCampusId(campusId);
                List<String> buildings = new ArrayList<>();
                for (Classroom classroom : classrooms) {
                    if (!buildings.contains(classroom.getBuildingName())) {
                        buildings.add(classroom.getBuildingName());
                    }
                }
                data.put("buildings",buildings);
            }
            return Result.ok(data);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail();
        }
    }

    @GetMapping("/campuses")
    public Result<List<Campus>> getAllCampuses() {
        try {
            List<Campus> result = architectureService.getAllCampuses();;
            return Result.ok(result);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/classrooms")
    public Result<Object> getClassrooms(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String,Object> conditions) {
        Integer campusId = (Integer) conditions.get("campusId");
        String buildingName = (String) conditions.get("buildingName");
        List<Classroom> classrooms = null;
        try {
            classrooms = architectureService.getClassroomByCampusIdAndBuildingName(campusId,buildingName);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
        Map<String,Object> data = new HashMap<>();
        List<Map<String,Object>> dataValue = new ArrayList<>();
        Map<String,Object> dataValueNode = new HashMap<>();
        if(!primaryInfo.startsWith("X")){
            for (Classroom classroom : classrooms){
                dataValueNode.put("classroomId",classroom.getId());
                dataValueNode.put("classroomName",classroom.getRoomNumber());
                dataValue.add(dataValueNode);
            }
            data.put("classrooms",dataValue);
        }else{
            Integer offset = (Integer) conditions.get("offset");
            Integer num = (Integer) conditions.get("num");
            List<Campus> campuses = architectureService.getAllCampuses();
            Map<Integer,String> campusId2Name = new HashMap<>();
            for (Campus campus : campuses){
                campusId2Name.put(campus.getId(),campus.getName());
            }
            for(int i = offset;i<offset+num;i++){
                if(i>=classrooms.size()){
                    break;
                }
                dataValueNode.put("classroomId",classrooms.get(i).getId());
                dataValueNode.put("classroomName",classrooms.get(i).getRoomNumber());
                dataValueNode.put("campusName",campusId2Name.get(classrooms.get(i).getCampusId()));
                dataValueNode.put("building",classrooms.get(i).getBuildingName());
                dataValueNode.put("seatNum",classrooms.get(i).getSeatNum());
                dataValueNode.put("area",classrooms.get(i).getArea());
                dataValueNode.put("status",architectureService.getClassroomStatusById(classrooms.get(i).getCampusId()).getStatus() == 1 ? "正常" : "维修中");
                dataValue.add(dataValueNode);
            }
            Integer sum = classrooms.size()/num+1;
            data.put("sum",sum);
            data.put("classrooms",dataValue);

        }
        return Result.ok(data);
    }


    @PostMapping("/classroomStatus")
    public Result<Object> getClassroomStatus(@RequestBody Map<String,Object> conditions) {
        Integer classroomId = (Integer) conditions.get("classroomId");
        Integer year = (Integer) conditions.get("year");
        Integer week = (Integer) conditions.get("month");
        Integer dayOfWeek = (Integer) conditions.get("dayOfWeek");
        Integer periodFrom = (Integer) conditions.get("periodFrom");
        Integer periodTo = (Integer) conditions.get("periodTo");
        Boolean termPart = (Boolean) conditions.get("termPart");
        List<ClassroomStatus> classroomStatuses = null;
        try {
            classroomStatuses = architectureService.getClassroomStatusBySpecificTimeRegion(year, classroomId, week, termPart ? 1 : 0, dayOfWeek, periodFrom, periodTo);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
        Map<String,Object> data = new HashMap<>();
        List<Map<String,Object>> dataValue = new ArrayList<>();
        for (ClassroomStatus classroomStatus : classroomStatuses) {
            Map<String,Object> value = new HashMap<>();
            value.put("status",classroomStatus.getStatus());
            value.put("periodFrom",classroomStatus.getPeriodFrom());
            value.put("periodTo",classroomStatus.getPeriodTo());
            dataValue.add(value);
        }
        data.put("status_list",dataValue);
        return Result.ok(data);
    }

    @PostMapping("/classroomReservations")
    public Result<Object> getClassroomReservation(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String,Object> conditions) {
        Integer campusId = (Integer) conditions.get("campusId");
        Integer result = (Integer) conditions.get("result");
        String buildingName = (String) conditions.get("buildingName");
        List<ClassroomReservation> classroomReservations = new ArrayList<>();
        try{
            List<Classroom> classrooms = architectureService.getClassroomByCampusIdAndBuildingName(campusId,buildingName);
            for (Classroom classroom : classrooms) {
                classroomReservations.addAll(architectureService.getClassroomReservationByClassroomIdAndResult(classroom.getId(),result));
            }
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
        Map<String,Object> data = new HashMap<>();
        List<Map<String,Object>> dataValue = new ArrayList<>();
        Integer offset = (Integer) conditions.get("offset");
        Integer num = (Integer) conditions.get("num");
        for(int i = offset;i<offset+num;i++){
            if(i>=classroomReservations.size()){
                break;
            }
            Map<String,Object> value = new HashMap<>();
            value.put("reservationId",classroomReservations.get(i).getId());
            value.put("teacherId",classroomReservations.get(i).getTeacherId());
            value.put("year",classroomReservations.get(i).getYear());
            value.put("week",classroomReservations.get(i).getWeek());
            value.put("dayOfWeek",classroomReservations.get(i).getDayOfWeek());
            value.put("periodFrom",classroomReservations.get(i).getClassPeriodFrom());
            value.put("periodTo",classroomReservations.get(i).getClassPeriodTo());
            value.put("reason",classroomReservations.get(i).getResult());
            value.put("reasonDetail",classroomReservations.get(i).getReasonDetail());
            value.put("actName",classroomReservations.get(i).getActName());
            dataValue.add(value);
        }
        Integer sum  = classroomReservations.size()/num+1;
        data.put("sum",sum);
        data.put("reservations",dataValue);
        return Result.ok(data);
    }
    @PostMapping("/confirmClassroomReservations")
    public Result<Object> maintsainanceRecord( @RequestBody Map<String, Object> conditions) {
        Integer reserveId = (Integer) conditions.get("reserveId");
        Integer result= (Integer) conditions.get("result");
        String detail= (String) conditions.get("detail");
        if(architectureService.updateClassroomReservationByResult(result,reserveId)) {
            return Result.ok();
        }else{
            return Result.fail();
        }
    }
}