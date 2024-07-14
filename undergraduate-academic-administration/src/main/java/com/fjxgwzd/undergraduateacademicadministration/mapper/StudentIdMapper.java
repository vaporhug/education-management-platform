package com.fjxgwzd.undergraduateacademicadministration.mapper;

import com.fjxgwzd.undergraduateacademicadministration.entity.Semester;
import com.fjxgwzd.undergraduateacademicadministration.vo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

@Mapper
@Repository
@Service
public interface StudentIdMapper {
    EducationPlanVO getEducationPlanByMajorId(@Param("majorId") Short major_id, @Param("cohortYear") Short cohort_year);
    List<CourseInfoVO> findCourseInstByStudentId(String studentId, Integer year, boolean termPart);
    StudentDetailInfoVO getStudentDetailInfoByStudentId(String studentId);
    List<CourseTaskVO> getCourseTaskByStudentId(String studentId, Integer year, boolean termPart, Integer week);
    List<Semester> getAllSemester();
}
