package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.mapper.StudentIdMapper;
import com.fjxgwzd.undergraduateacademicadministration.service.CourseService;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    StudentIdMapper studentIdMapper;

    @Override
    public List<CourseInfoVO> getCourseInfoByStudentId(String studentId, Integer year, boolean termPart) {
        return studentIdMapper.findCourseInstByStudentId(studentId, year, termPart);
    }
}
