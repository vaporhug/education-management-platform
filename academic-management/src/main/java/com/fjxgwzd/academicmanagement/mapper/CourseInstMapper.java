package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.CourseInst;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface CourseInstMapper extends ElasticsearchRepository<CourseInst,Integer> {
    List<CourseInst> findCourseInstsByCourseId(String courseId);
    CourseInst findCourseInstById(Integer id);
}
