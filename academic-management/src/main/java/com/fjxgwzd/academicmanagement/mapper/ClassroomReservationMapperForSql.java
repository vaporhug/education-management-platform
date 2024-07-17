package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.FaultReport;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;

@Mapper
public interface ClassroomReservationMapperForSql {
    @Insert("UPDATE classroom_reservation SET result = #{result} WHERE id = #{id} ")
    Boolean updateClassroomReservationByResult(Integer result, Integer id);
}
