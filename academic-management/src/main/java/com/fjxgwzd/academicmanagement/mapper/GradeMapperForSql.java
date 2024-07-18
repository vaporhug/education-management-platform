package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.vo.ExamScoreVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface GradeMapperForSql {
    @Select("select year, term_part as termPart, course_inst_id as courseInstId, c.name as courseName, score, credit, course_type as courseType, course_cate as courseCate from course_selection c_s join course_inst_section c_i_s on c_s.course_sec_id = c_i_s.id join course_inst c_i on c_i_s.course_inst_id = c_i.id join course c on c.id = c_i.course_id where c_s.stu_id = #{studentId} and c_i.year = #{year} and c_i.term_part = #{termPart}")
    public List<ExamScoreVO> getExamScoreByStudentId(String studentId, Integer year, boolean termPart) ;
}
