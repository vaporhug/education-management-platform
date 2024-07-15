package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.undergraduateacademicadministration.vo.*;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface AdministrationService {
    EducationPlanVO getEducationPlanByMajorId(Short majorId, Short cohortYear) throws JsonProcessingException;
    StudentDetailInfoVO getStudentDetailInfoByStudentId(String studentId) throws JsonProcessingException;
    DefaultCourseTableVO getDefaultCourseTableByStudentId(String studentId) throws Exception;
    List<CourseTaskVO> getCourseTaskByStudentId(String studentId, Integer year, boolean termPart, Integer week) throws JsonProcessingException;
    TotalStudentDetailVO getTotalStudentDetail(Short schoolId, Short majorId,Integer startYear,Integer classId,boolean gender,String name,Integer offset, Integer num) throws JsonProcessingException;
}
