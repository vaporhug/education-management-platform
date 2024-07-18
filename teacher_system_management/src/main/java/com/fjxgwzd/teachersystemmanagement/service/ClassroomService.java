package com.fjxgwzd.teachersystemmanagement.service;

import com.fjxgwzd.teachersystemmanagement.vo.CampusVO;
import com.fjxgwzd.teachersystemmanagement.vo.ClassroomVO;
import com.fjxgwzd.teachersystemmanagement.vo.ReservationRecordVO;

import java.util.List;

public interface ClassroomService {
    List<CampusVO> getCampusVO();
    List<ClassroomVO> getClassroomVO(Integer campusId,String building);
    String reserveClassroom(String teacherId,String name,String phoneNumber,Integer classroomId,Integer year,Boolean termPart,Integer week,Integer dayOfWeek,Integer periodFrom,Integer periodTo,Short reason,String reasonDetail);
    ReservationRecordVO getReservation(String teacherId, Integer offset, Integer num);
}
