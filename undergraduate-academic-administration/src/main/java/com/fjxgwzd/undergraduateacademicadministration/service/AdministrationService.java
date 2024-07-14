package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseTaskVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.DefaultCourseTableVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.EducationPlanVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.StudentDetailInfoVO;

import java.util.List;

public interface AdministrationService {
    EducationPlanVO getEducationPlanByMajorId(Short majorId, Short cohortYear) throws JsonProcessingException;
    StudentDetailInfoVO getStudentDetailInfoByStudentId(String studentId) throws JsonProcessingException;
    DefaultCourseTableVO getDefaultCourseTableByStudentId(String studentId) throws Exception;
    List<CourseTaskVO> getCourseTaskByStudentId(String studentId, Integer year, boolean termPart, Integer week) throws JsonProcessingException;
}
