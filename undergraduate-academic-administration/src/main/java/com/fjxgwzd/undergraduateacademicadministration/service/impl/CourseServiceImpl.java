package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fjxgwzd.undergraduateacademicadministration.mapper.StudentIdMapper;
import com.fjxgwzd.undergraduateacademicadministration.service.CourseService;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseInfoVO;
import com.fjxgwzd.undergraduateacademicadministration.vo.CourseStudentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    StudentIdMapper studentIdMapper;

    @Override
    public List<CourseInfoVO> getCourseInfoByStudentId(String studentId, Integer year, boolean termPart) {
        List<CourseInfoVO>  courseInfoVOList= studentIdMapper.findCourseInstByStudentId(studentId, year, termPart);
        for(CourseInfoVO courseInfoVO:courseInfoVOList){
            courseInfoVO.setCourseCate(changeCourseCate(courseInfoVO.getCourseCate()));
            courseInfoVO.setCourseType(changeCourseType(courseInfoVO.getCourseType()));
            courseInfoVO.setCourseFor(changeCourseFor(courseInfoVO.getCourseFor()));
        }
        return courseInfoVOList;
    }

    public String changeCourseType(String schoolId) {
        Map<String, String> CourseTypeMap = new HashMap<>();
        CourseTypeMap.put("1", "全校性选修课");
        CourseTypeMap.put("2", "专业必修课");
        CourseTypeMap.put("3", "专业选修课");
        String CourseTypeDescription = CourseTypeMap.getOrDefault(schoolId, "未知课程类型");
        return CourseTypeDescription;
    }

    public String changeCourseCate(String schoolId) {
        Map<String, String> CourseCateMap = new HashMap<>();
        CourseCateMap.put("1", "自然科学类");
        CourseCateMap.put("2", "人文社科类");
        CourseCateMap.put("3", "艺术类");
        CourseCateMap.put("4", "体育类");
        CourseCateMap.put("5", "科研实践类");
        String CourseCateDescription = CourseCateMap.getOrDefault(schoolId, "未知课程类型");
        return CourseCateDescription;
    }

    public String changeCourseFor(String schoolId) {
        Map<String, String> CourseForMap = new HashMap<>();
        CourseForMap.put("1", "软件工程");
        CourseForMap.put("2", "计算机科学与技术");
        CourseForMap.put("3", "信息安全");
        CourseForMap.put("4", "人工智能");
        CourseForMap.put("5", "物联网");
        String CourseForDescription = CourseForMap.getOrDefault(schoolId, "未知专业类型");
        return CourseForDescription;
    }

    @Override
    public CourseStudentVO getCourseStudent(Integer courseInstId, Integer offset, Integer num) {
        CourseStudentVO courseStudentVO = new CourseStudentVO();
        courseStudentVO.setStudentSum(studentIdMapper.getStudentSum(courseInstId));
        courseStudentVO.setStudentVOList(studentIdMapper.getCourseStudent(courseInstId,offset,num));
        return courseStudentVO;
    }
}
