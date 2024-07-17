package com.fjxgwzd.teachersystemmanagement.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teachersystemmanagement.vo.*;

import java.util.List;

public interface TeacherService {
    TeacherDetailInfoVO getTeacherDetailInfo(String teacherId);
    TeacherResearchFindings teacherResearchFindings(String teacherId,Integer type, Integer offset, Integer num);
    DefaultCourseTableVO getDefaultCourseTableByTeacherId(String teacherId) throws Exception;
    List<CourseTaskVO> getCourseTaskByTeacherId(String teacherId, Integer year, boolean termPart, Integer week) throws JsonProcessingException;
    TotalTeacherDetailVO getTotalTeacherDetail(Short schoolId, Short majorId, Integer title, String name, Boolean gender, Integer offset, Integer num);
    String uploadGrades(String courseInstId, GradeVO[] stuScores);
}
