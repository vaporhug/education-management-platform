package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.School;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.data.elasticsearch.repository.cdi.ElasticsearchRepositoryBean;

import java.util.List;

public interface SchoolMapper extends ElasticsearchRepository<School,String> {
    School findSchoolById(Integer schoolId);
}
