package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.Campus;
import com.fjxgwzd.academicmanagement.entity.Classroom;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ArchitectureMapper {
    @Select("SELECT * FROM campus")
    List<Campus> findAllCampuses();

    @Select("SELECT * FROM classroom")
    List<Classroom> findAllClassroom();

    @Select("SELECT * FROM campus WHERE id = #{id}")
    Campus findCampusById(Integer id);
}
