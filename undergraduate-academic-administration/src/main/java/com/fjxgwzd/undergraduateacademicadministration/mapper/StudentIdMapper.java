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
    EducationPlanVO getEducationPlanByMajorId( Short majorId, Short cohortYear);
    List<CourseInfoVO> findCourseInstByStudentId(String studentId, Integer year, boolean termPart);
    StudentDetailInfoVO getStudentDetailInfoByStudentId(String studentId);
    List<CourseTaskVO> getCourseTaskByStudentId(String studentId, Integer year, boolean termPart, Integer week);
    List<Semester> getAllSemester();
    List<StudentDetailInfoVO> getTotalStudentDetail(Short schoolId, Short majorId, Integer startYear, Integer classId, Boolean gender, String name, Integer offset, Integer num);
    Integer getSum(Short schoolId, Short majorId, Integer startYear, Integer classId, Boolean gender, String name);
    Integer getStudentSum(Integer courseInstId);
    List<StudentVO> getCourseStudent(Integer courseInstId, Integer offset, Integer num);

}
