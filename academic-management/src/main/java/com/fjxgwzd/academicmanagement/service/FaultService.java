package com.fjxgwzd.academicmanagement.service;

import com.fjxgwzd.academicmanagement.entity.FaultReport;
import com.fjxgwzd.academicmanagement.entity.MaintainanceFaultType;
import com.fjxgwzd.academicmanagement.entity.MaintainanceRecord;
import com.fjxgwzd.academicmanagement.mapper.FaultReportMapper;
import com.fjxgwzd.academicmanagement.mapper.FaultReportMapperForSql;
import com.fjxgwzd.academicmanagement.mapper.MaintainanceFaultTypeMapper;
import com.fjxgwzd.academicmanagement.mapper.MaintainanceRecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class FaultService {
    @Autowired
    private FaultReportMapper faultReportMapper;

    @Autowired
    private FaultReportMapperForSql faultReportMapperForSql;

    @Autowired
    private MaintainanceRecordMapper maintainanceRecordMapper;

    @Autowired
    private MaintainanceFaultTypeMapper maintainanceFaultTypeMapper;

    public List<FaultReport> getFaultReportsByClassroomId(Integer classroomId,Integer status) {
        return faultReportMapper.findFaultReportsByClassroomIdAndStatus(classroomId ,status);
    }

    public List<FaultReport> getFaultReportsByStatusAndIdentity(Integer classroomId,String identity) {
        return faultReportMapper.findFaultReportsByStatusAndIdentity(classroomId,identity);
    }

    public List<FaultReport> getFaultReportsByIdentity(String identity) {
        return faultReportMapper.findFaultReportsByIdentity(identity);
    }

    public Integer findFaultTypeByFaultRecordId(Integer faultRecordId) {
        FaultReport faultReport = faultReportMapper.findById(faultRecordId).orElse(null);
        if (faultReport == null) {
            return null;
        }

        MaintainanceRecord maintainanceRecord = maintainanceRecordMapper.findByReportId(faultReport.getId());
        if (maintainanceRecord == null) {
            return null;
        }

        MaintainanceFaultType maintainanceFaultType = maintainanceFaultTypeMapper.findMaintainanceFaultTypeById(maintainanceRecord.getId());
        if (maintainanceFaultType == null) {
            return null;
        }

        return maintainanceFaultType.getType();
    }

    public Boolean insertFaultReport(FaultReport faultReport) {
        try {
            faultReportMapperForSql.insertFaultReport(faultReport);
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    public List<FaultReport> getFaultReportsByClassroomIds(List<Integer> classroomId) {
        List<FaultReport> faultReports = new ArrayList<>();
        for (Integer id : classroomId) {
            faultReports.addAll(faultReportMapper.findFaultReportsByClassroomId(id));
        }
        return faultReports;
    }
}
