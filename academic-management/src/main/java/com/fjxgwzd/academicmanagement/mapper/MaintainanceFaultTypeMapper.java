package com.fjxgwzd.academicmanagement.mapper;

import com.fjxgwzd.academicmanagement.entity.MaintainanceFaultType;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface MaintainanceFaultTypeMapper extends ElasticsearchRepository<MaintainanceFaultType,Integer>{
    MaintainanceFaultType findMaintainanceFaultTypeById(Integer id);
    MaintainanceFaultType findMaintainanceFaultTypeByMaintId(Integer maintId);
    MaintainanceFaultType findMaintainanceFaultTypeByType(Integer type);
    MaintainanceFaultType findMaintainanceFaultTypeByExtraDesc(String extraDesc);
}
