package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.undergraduateacademicadministration.mapper.StudentIdMapper;
import com.fjxgwzd.undergraduateacademicadministration.service.AdministrationService;
import com.fjxgwzd.undergraduateacademicadministration.vo.EducationPlanVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdministrationImpl implements AdministrationService {
    @Autowired
    StudentIdMapper studentIdMapper;

    @Override
    public EducationPlanVO getEducationPlanByMajorId(Short majorId, Short cohortYear) throws JsonProcessingException {
        EducationPlanVO educationPlanVO = studentIdMapper.getEducationPlanByMajorId(majorId,cohortYear);
        return educationPlanVO;
    }

    //    @Override
//    public EducationPlanVO getEducationPlanByMajorId(Short majorId) throws JsonProcessingException {
//        EducationPlanVO educationPlanVO = studentIdMapper.getEducationPlanByMajorId(majorId, cohortYear);
//        return educationPlanVO;
////        ObjectMapper objectMapper = new ObjectMapper();
////        objectMapper.setSerializationInclusion(JsonInclude.Include.ALWAYS);
//////        System.out.println(educationPlanVO.getCourseNames());
//////        System.out.println(educationPlanVO.getCoreCourseIds());
//////        System.out.println(educationPlanVO.getCreditReqNames());
//////        System.out.println(educationPlanVO.getCreditReqTotals());
////        return objectMapper.writeValueAsString(educationPlanVO);
//    }
}
