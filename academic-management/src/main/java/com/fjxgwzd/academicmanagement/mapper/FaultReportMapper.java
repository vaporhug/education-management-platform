package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.FaultReport;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;

public interface FaultReportMapper extends ElasticsearchRepository<FaultReport,Integer> {
    List<FaultReport> findFaultReportsByClassroomIdAndStatus(Integer classroomId,Integer status);
    List<FaultReport> findFaultReportsByStatusAndIdentity(Integer classroomId,String identity);
    List<FaultReport> findFaultReportsByIdentity(String classroomId);
    FaultReport findFaultById(Integer id);

    List<FaultReport> findFaultReportsByClassroomId(Integer classroomId);
}
