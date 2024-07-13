package com.fjxgwzd.undergraduateacademicadministration.mapper;

import com.fjxgwzd.undergraduateacademicadministration.vo.EducationPlanVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Mapper
@Repository
@Service
public interface StudentIdMapper {
    EducationPlanVO getEducationPlanByMajorId(@Param("majorId") Short major_id, @Param("cohortYear") Short cohort_year);
}
