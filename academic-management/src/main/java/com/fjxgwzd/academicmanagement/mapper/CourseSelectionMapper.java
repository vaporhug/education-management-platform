package com.fjxgwzd.academicmanagement.mapper;


import com.fjxgwzd.academicmanagement.entity.CourseSelection;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface CourseSelectionMapper extends ElasticsearchRepository<CourseSelection,Integer> {
    List<CourseSelection> findCourseSelectionsByStudentId(String studentId);
}
