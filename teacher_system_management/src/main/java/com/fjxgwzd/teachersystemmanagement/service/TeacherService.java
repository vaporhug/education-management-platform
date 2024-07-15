package com.fjxgwzd.teachersystemmanagement.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teachersystemmanagement.vo.CourseTaskVO;
import com.fjxgwzd.teachersystemmanagement.vo.DefaultCourseTableVO;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherDetailInfoVO;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherResearchFindings;

import java.util.List;

public interface TeacherService {
    TeacherDetailInfoVO getTeacherDetailInfo(String teacherId);
    TeacherResearchFindings teacherResearchFindings(String teacherId, Integer offset, Integer num);
    DefaultCourseTableVO getDefaultCourseTableByTeacherId(String teacherId) throws Exception;
    List<CourseTaskVO> getCourseTaskByTeacherId(String teacherId, Integer year, boolean termPart, Integer week) throws JsonProcessingException;
}
