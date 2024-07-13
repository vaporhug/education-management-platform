package com.fjxgwd.teachersystemmanagement.service.impl;


import com.fjxgwd.teachersystemmanagement.vo.EduExpVO;
import com.fjxgwd.teachersystemmanagement.vo.TeacherResearchFinding;
import com.fjxgwd.teachersystemmanagement.vo.TeacherResearchFindings;
import org.springframework.beans.factory.annotation.Autowired;
import com.fjxgwd.teachersystemmanagement.mapper.TeacherMapper;
import com.fjxgwd.teachersystemmanagement.service.TeacherService;
import com.fjxgwd.teachersystemmanagement.vo.TeacherDetailInfoVO;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class TeacherInfoImpl implements TeacherService {
    @Autowired
    TeacherMapper teacherMapper;

    @Override
    public TeacherDetailInfoVO getTeacherDetailInfo(String teacherId) {
        TeacherDetailInfoVO teacherDetailInfoVO = teacherMapper.getTeacherDetailInfoByTeacherId(teacherId);
        List<EduExpVO> eduExpVOS = teacherMapper.getEduExpByTeacherId(teacherId);
        teacherDetailInfoVO.setEduExpList(eduExpVOS);
        return teacherDetailInfoVO;
    }

    @Override
    public TeacherResearchFindings teacherResearchFindings(String teacherId, Integer offset, Integer num) {
        // 由offset为开始
        // num为获取总数
        List<TeacherResearchFinding> teacherResearchFindingList = teacherMapper.getTeacherResearchFindingsByTeacherId(teacherId,offset,num);
        TeacherResearchFindings teacherResearchFindings = new TeacherResearchFindings();
        teacherResearchFindings.setTeacherResearchFindings(teacherResearchFindingList);
        // 获取总数，此时暂时使用每次都计算
        teacherResearchFindings.setSum(teacherMapper.getTeacherResearchFindingsCountByTeacherId(teacherId)/num);
        return teacherResearchFindings;
    }
}
