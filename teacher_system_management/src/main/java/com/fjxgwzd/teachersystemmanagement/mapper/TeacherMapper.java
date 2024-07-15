package com.fjxgwzd.teachersystemmanagement.mapper;

import com.fjxgwzd.teachersystemmanagement.entity.Semester;
import com.fjxgwzd.teachersystemmanagement.vo.CourseTaskVO;
import com.fjxgwzd.teachersystemmanagement.vo.EduExpVO;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherDetailInfoVO;
import com.fjxgwzd.teachersystemmanagement.vo.TeacherResearchFinding;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface TeacherMapper {
    TeacherDetailInfoVO getTeacherDetailInfoByTeacherId(String teacherId);
    List<EduExpVO> getEduExpByTeacherId(String teacherId);
    List<TeacherResearchFinding> getTeacherResearchFindingsByTeacherId(String teacherId, Integer offset, Integer num);
    Integer getTeacherResearchFindingsCountByTeacherId(String teacherId);
    List<CourseTaskVO> getCourseTaskByTeacherId(String teacherId, Integer year, boolean termPart, Integer week);
    List<Semester> getAllSemester();
}
