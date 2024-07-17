package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.MaintainanceRecord;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface MaintainanceRecordMapper extends ElasticsearchRepository<MaintainanceRecord,Integer>{
    MaintainanceRecord findByReportId(Integer reportId);
}
