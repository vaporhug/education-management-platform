package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.Course;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface CourseMapper extends ElasticsearchRepository<Course,String> {
    Course findCourseById(String courseId);
}
