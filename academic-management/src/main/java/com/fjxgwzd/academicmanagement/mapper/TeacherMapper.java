package com.fjxgwzd.academicmanagement.mapper;


import com.fjxgwzd.academicmanagement.entity.Teacher;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface TeacherMapper extends ElasticsearchRepository<Teacher,Integer> {
    Teacher findTeacherById(String id);
}
