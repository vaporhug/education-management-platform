package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.Teach;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface TeachMapper extends ElasticsearchRepository<Teach,Integer> {
    List<Teach> findTeachesByTeacherId(String teacherId);
}