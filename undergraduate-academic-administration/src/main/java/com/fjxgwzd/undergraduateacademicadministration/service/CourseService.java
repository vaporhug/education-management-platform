package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fjxgwzd.undergraduateacademicadministration.vo.CourseInfoVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseStudentVO;

import java.util.List;

public interface CourseService {
    List<CourseInfoVO> getCourseInfoByStudentId(String studentId, Integer year, boolean termPart);
    CourseStudentVO getCourseStudent(Integer courseInstId, Integer offset, Integer num);
}
