package com.fjxgwzd.academicmanagement;

import com.fjxgwzd.academicmanagement.entity.*;
import com.fjxgwzd.academicmanagement.mapper.ClassroomStatusMapper;
import com.fjxgwzd.academicmanagement.service.ArchitectureService;
import com.fjxgwzd.academicmanagement.service.FaultService;
import com.fjxgwzd.academicmanagement.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class AcademicManagementApplicationTests {

    @Autowired
    private ArchitectureService architectureService;
    @Autowired
    private FaultService faultService;
    @Autowired
    private UserService userService;
    @Autowired
    private ClassroomStatusMapper classroomStatusMapper;

    @Test
    public void ArchitectureTest() {
//        List<ClassroomReservation> classroomReservations = architectureService.getClassroomReservationByClassroomIdAndResult(12,1);
//        System.out.println(classroomReservations);

//        List<ClassroomStatus> classroomStatuses =architectureService.getClassroomStatusBySpecificTimeRegion(2024,12,3,1,3,2,9);
//        System.out.println(classroomStatuses);

//        Integer faultType = faultService.findFaultTypeByFaultRecordId(1);
//        System.out.println(faultType);

//        Teacher teacher = userService.getTeacherById("12345678");
//        System.out.println(teacher);

//        Classroom classroom = architectureService.getClassroomById(1);
//        System.out.println(classroom);

//        List<FaultReport> f = faultService.getFaultReportsByClassroomId(13,1);
//        List<FaultReport> faultReports = faultService.getFaultReportsByStatusAndIdentity(13,"12345678");
//        List<FaultReport> faultReports1 = faultService.getFaultReportsByIdentity("12345678");
//        System.out.println(faultReports);
//        System.out.println(f);
//        System.out.println(faultReports1);

//        Map<Integer, String> buildings = architectureService.getAllBuildings();
//        System.out.println(buildings);

//        List<Classroom> classrooms = architectureService.getClassroomByCampusIdAndBuildingName(2,"å®žéªŒæ¥¼");
//        System.out.println(classrooms);
//        assertThat(classrooms).isNotNull();

//        List<School> schools = schoolService.findAllSchools();
//        System.out.println(schools);
//        assertThat(schools).isNotNull();

//        List<Campus> campuses = architectureService.getAllCampuses();
//        System.out.println(campuses);
//        assertThat(campuses).isNotNull();

        List<Classroom> campuses = architectureService.getClassroomByCampusIdAndBuildingName(3,"教学楼");
        System.out.println(campuses);
        assertThat(campuses).isNotNull();
    }

}
