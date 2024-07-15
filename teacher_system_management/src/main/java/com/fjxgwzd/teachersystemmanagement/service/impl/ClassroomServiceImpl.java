package com.fjxgwzd.teachersystemmanagement.service.impl;

import com.fjxgwzd.teachersystemmanagement.mapper.ClassroomMapper;
import com.fjxgwzd.teachersystemmanagement.service.ClassroomService;
import com.fjxgwzd.teachersystemmanagement.vo.CampusVO;
import com.fjxgwzd.teachersystemmanagement.vo.ClassroomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClassroomServiceImpl implements ClassroomService {
    @Autowired
    ClassroomMapper classroomMapper;

    @Override
    public List<CampusVO> getCampusVO() {
        List<CampusVO> campusVOList = classroomMapper.getCampusVO();
        return campusVOList;
    }

    @Override
    public List<ClassroomVO> getClassroomVO(Integer campusId,String building) {
        List<ClassroomVO> classroomVOList = classroomMapper.getClassroomVO(campusId,building);
        return classroomVOList;
    }

    @Override
    public String reserveClassroom(String teacherId, String name, String phoneNumber, Integer campusId, String buildingName, Integer classroomId, Integer year, boolean termPart, Integer week, Integer dayOfWeek, Integer periodFrom, Integer periodTo, Short reason, String reasonDetail) {
        classroomMapper.reserveClassroom(teacherId,name,phoneNumber, campusId, buildingName, classroomId, year, termPart, week, dayOfWeek, periodFrom, periodTo, reason, reasonDetail);
        return "成功申请";
    }
}
