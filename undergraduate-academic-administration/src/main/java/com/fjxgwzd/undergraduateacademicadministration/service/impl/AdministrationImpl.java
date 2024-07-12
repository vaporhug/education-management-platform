package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fjxgwzd.undergraduateacademicadministration.mapper.StudentIdMapper;
import com.fjxgwzd.undergraduateacademicadministration.service.AdministrationService;
import com.fjxgwzd.undergraduateacademicadministration.vo.EducationPlanVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdministrationImpl implements AdministrationService {
    @Autowired
    StudentIdMapper studentIdMapper;

    @Override
    public String getEducationPlanByMajorId(Short majorId) throws JsonProcessingException {
        EducationPlanVO educationPlanVO = studentIdMapper.getEducationPlanByMajorId(majorId);
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(educationPlanVO);
    }
}
