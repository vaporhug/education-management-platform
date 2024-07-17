package com.fjxgwzd.academicmanagement.service;

import com.fjxgwzd.academicmanagement.entity.*;
import com.fjxgwzd.academicmanagement.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CourseService {
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private CourseInstMapper courseInstMapper;
    @Autowired
    private CourseInstSectionMapper courseInstSectionMapper;
    @Autowired
    private TeachMapper teachMapper;
    @Autowired
    private CourseSelectionMapper courseSelectionMapper;

    public List<String> getCourseIdsByTeacherId(String teacherId) {
        List<String> courseIds = new ArrayList<>();
        for(Teach teach :teachMapper.findTeachesByTeacherId(teacherId)) {
            courseIds.add(teach.getCourseId());
        }
        return courseIds;
    }
    public List<Course> getCoursesByCourseIds(List<String> courseIds) {
        List<Course> courses = new ArrayList<>();
        for (String courseId : courseIds) {
            courses.add(courseMapper.findCourseById(courseId));
        }
        return courses;
    }

    public Course getCoursesByCourseId(String courseId) {
        return courseMapper.findCourseById(courseId);
    }

    public List<CourseInst> getCourseInstsByCourseIds(List<String> courseIds) {
        List<CourseInst> courseInsts = new ArrayList<>();
        for (String courseId : courseIds) {
             courseInsts.addAll(courseInstMapper.findCourseInstsByCourseId(courseId));
        }
        return courseInsts;
    }

    public List<CourseInstSection> getCourseInstSectionsByCourseInstId(Integer courseInstId) {
        return courseInstSectionMapper.findCourseInstSectionsByCourseInstId(courseInstId);
    }

    public List<String> getCourseInstSectionsIdsByStudentId(String studentId){
        List<String> courseSecIds = new ArrayList<>();
        for (CourseSelection courseSelection : courseSelectionMapper.findCourseSelectionsByStudentId(studentId)) {
            courseSecIds.add(courseSelection.getCourseSecId());
        }
        return courseSecIds;
    }

    public CourseInstSection getCourseInstSectionById(Integer id) {
        return courseInstSectionMapper.findCourseInstSectionById(id);
    }

    public CourseInst getCourseInstById(Integer id) {
        return courseInstMapper.findCourseInstById(id);
    }

}

