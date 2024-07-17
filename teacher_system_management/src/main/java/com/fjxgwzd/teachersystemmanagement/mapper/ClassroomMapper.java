package com.fjxgwzd.teachersystemmanagement.mapper;

import com.fjxgwzd.teachersystemmanagement.vo.CampusVO;
import com.fjxgwzd.teachersystemmanagement.vo.ClassroomVO;
import com.fjxgwzd.teachersystemmanagement.vo.RecordVO;

import java.util.List;

public interface ClassroomMapper {
    List<CampusVO> getCampusVO();
    List<ClassroomVO> getClassroomVO(Integer campusId,String building);
    void reserveClassroom(String teacherId,String name,String phoneNumber,Integer classroomId,Integer year,boolean termPart,Integer week,Integer dayOfWeek,Integer periodFrom,Integer periodTo,Short reason,String reasonDetail);
    List<RecordVO> getRecords(String teacherId, Integer offset, Integer num);
    Integer getSum(String teacherId);
}
