package com.fjxgwzd.teachersystemmanagement.service.impl;


import com.fjxgwzd.teachersystemmanagement.vo.EduExpVO;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherResearchFinding;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherResearchFindings;
import org.springframework.beans.factory.annotation.Autowired;
import com.fjxgwzd.teachersystemmanagement.mapper.TeacherMapper;
import com.fjxgwzd.teachersystemmanagement.service.TeacherService;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherDetailInfoVO;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TeacherInfoImpl implements TeacherService {
    @Autowired
    TeacherMapper teacherMapper;

    @Override
    public TeacherDetailInfoVO getTeacherDetailInfo(String teacherId) {
        TeacherDetailInfoVO teacherDetailInfoVO = teacherMapper.getTeacherDetailInfoByTeacherId(teacherId);

        teacherDetailInfoVO.setBachelor(changeBachelor(teacherDetailInfoVO.getBachelor()));
        teacherDetailInfoVO.setType(changeTeacherType(teacherDetailInfoVO.getType()));
        teacherDetailInfoVO.setTitle(changeTeacherTitle(teacherDetailInfoVO.getTitle()));

        List<EduExpVO> eduExpVOS = teacherMapper.getEduExpByTeacherId(teacherId);
        for (EduExpVO eduExpVO : eduExpVOS) {
            eduExpVO.setBachelor(changeTeacherType(eduExpVO.getBachelor()));
        }
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
    public String changeBachelor(String bachelorId) {
        Map<String, String> bachelorMap = new HashMap<>();
        bachelorMap.put("1", "学士学位");
        bachelorMap.put("2", "硕士学位");
        bachelorMap.put("3", "博士学位");
        String bachelorDescription = bachelorMap.getOrDefault(bachelorId, "未知学位");
        return bachelorDescription;
    }

    public String changeTeacherType(String schoolId) {
        Map<String, String> TeacherTypeMap = new HashMap<>();
        TeacherTypeMap.put("1", "专职教师");
        TeacherTypeMap.put("2", "校内兼职教师");
        TeacherTypeMap.put("3", "校外兼职教师");
        String TeacherTypeDescription = TeacherTypeMap.getOrDefault(schoolId, "未知职位");
        return TeacherTypeDescription;
    }

    public String changeTeacherTitle(String schoolId) {
        Map<String, String> TeacherTitleMap = new HashMap<>();
        TeacherTitleMap.put("1", "讲师");
        TeacherTitleMap.put("2", "副教授");
        TeacherTitleMap.put("3", "正教授");
        String TeacherTitleDescription = TeacherTitleMap.getOrDefault(schoolId, "未知职称");
        return TeacherTitleDescription;
    }
}
