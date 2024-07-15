package com.fjxgwzd.teachersystemmanagement.mapper;

import com.fjxgwzd.teachersystemmanagement.vo.CampusVO;
import com.fjxgwzd.teachersystemmanagement.vo.ClassroomVO;

import java.util.List;

public interface ClassroomMapper {
    List<CampusVO> getCampusVO();
    List<ClassroomVO> getClassroomVO(Integer campusId,String building);
    void reserveClassroom(String teacherId,String name,String phoneNumber,Integer campusId,String buildingName,Integer classroomId,Integer year,boolean termPart,Integer week,Integer dayOfWeek,Integer periodFrom,Integer periodTo,Short reason,String reasonDetail);
}
