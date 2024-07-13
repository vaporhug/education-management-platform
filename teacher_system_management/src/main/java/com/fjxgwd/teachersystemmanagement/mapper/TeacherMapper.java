package com.fjxgwd.teachersystemmanagement.mapper;

import com.fjxgwd.teachersystemmanagement.vo.EduExpVO;
import com.fjxgwd.teachersystemmanagement.vo.TeacherDetailInfoVO;
import com.fjxgwd.teachersystemmanagement.vo.TeacherResearchFinding;

import java.util.List;

public interface TeacherMapper {
    TeacherDetailInfoVO getTeacherDetailInfoByTeacherId(String teacherId);
    List<EduExpVO> getEduExpByTeacherId(String teacherId);
    List<TeacherResearchFinding> getTeacherResearchFindingsByTeacherId(String teacherId, Integer offset,Integer num);
    Integer getTeacherResearchFindingsCountByTeacherId(String teacherId);
}
