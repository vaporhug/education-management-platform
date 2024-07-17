package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.FaultReport;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;

@Mapper
public interface FaultReportMapperForSql {
    @Insert("INSERT INTO fault_report (classroom_id, reporter_role, identity, fault_desc, report_time, status) " +
            "VALUES (#{classroomId}, #{reporterRole}, #{identity}, #{faultDesc}, #{reportTime}, #{status})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    Boolean insertFaultReport(FaultReport faultReport);
}
