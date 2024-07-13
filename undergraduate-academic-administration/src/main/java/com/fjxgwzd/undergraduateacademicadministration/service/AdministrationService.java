package com.fjxgwzd.undergraduateacademicadministration.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.undergraduateacademicadministration.vo.EducationPlanVO;

public interface AdministrationService {
    EducationPlanVO getEducationPlanByMajorId(Short majorId, Short cohortYear) throws JsonProcessingException;
}
