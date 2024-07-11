package com.fjxgwzd.teacherresourcesharing.service;

import com.fasterxml.jackson.core.JsonProcessingException;

public interface CourseService {
    String coursesInfo(String teacherId) throws JsonProcessingException;
    String courseDetailsInfo(Integer chapter_id) throws JsonProcessingException;
}
