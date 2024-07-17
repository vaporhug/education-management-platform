package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.CourseInstSection;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface CourseInstSectionMapper extends ElasticsearchRepository<CourseInstSection,Integer>  {
    List<CourseInstSection> findCourseInstSectionsByCourseInstId(Integer id);
    CourseInstSection findCourseInstSectionById(Integer id);
}
