package com.fjxgwzd.teachersystemmanagement.contorller;



import com.fjxgwzd.teachersystemmanagement.service.ClassroomService;
import com.fjxgwzd.teachersystemmanagement.vo.CampusVO;
import com.fjxgwzd.teachersystemmanagement.vo.ClassroomVO;
import com.fjxgwzd.teachersystemmanagement.vo.ReservationRecordVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.fjxgwzd.common.result.Result;
import java.util.List;
import java.util.Map;

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
//    public Result<List<ClassroomVO>> getClassroom(@RequestParam("campusId") Integer campusId, @RequestParam("building") String building){
    public Result<List<ClassroomVO>> getClassroom(@RequestBody Map<String, Object> conditions){
        try {
            Integer campusId = (Integer) conditions.get("campusId");
            String building = (String) conditions.get("building");
            return Result.ok(classroomService.getClassroomVO(campusId,building));
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/reserveClassroom")
//    public Result<String> reserveClassroom(String teacherId,String name,String phoneNumber,Integer campusId,String buildingName,Integer classroomId,Integer year,boolean termPart,Integer week,Integer dayOfWeek,Integer periodFrom,Integer periodTo,Short reason,String reasonDetail){
    public Result<String> reserveClassroom(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> condition){
        try {
            String name = (String) condition.get("name");
            String phoneNumber = (String) condition.get("phoneNumber");
//            Integer campusId = (Integer) condition.get("campusId");
//            String buildingName = (String) condition.get("buildingName");
            Integer classroomId = (Integer) condition.get("classroomId");
            Integer year =  (Integer) condition.get("year");
            boolean termPart = (Boolean) condition.get("termPart");
            Integer week =  (Integer) condition.get("week");
            Integer dayOfWeek =  (Integer) condition.get("dayOfWeek");
            Integer periodFrom = (Integer) condition.get("periodFrom");
            Integer periodTo = (Integer) condition.get("periodTo");
            Short reason = (Short) condition.get("reason");
            String reasonDetail = (String) condition.get("reasonDetail");
            return Result.ok(classroomService.reserveClassroom(primaryInfo,name,phoneNumber, classroomId, year, termPart, week, dayOfWeek, periodFrom, periodTo, reason, reasonDetail));
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/getReservation")
    public Result<ReservationRecordVO> getReservation(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> condition){
//    public Result<ReservationRecordVO> getReservation(String teacherId,Integer offset,Integer num){
        try {
            Integer offset = (Integer) condition.get("offset");
            Integer num = (Integer) condition.get("num");
            return Result.ok(classroomService.getReservation(primaryInfo,offset,num));
        } catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }

    }
}
