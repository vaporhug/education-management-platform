package com.fjxgwzd.teachersystemmanagement.vo;

import lombok.Data;

import java.util.List;

@Data
public class ReservationRecordVO {
    private Integer recordSum;
    private List<RecordVO> recordVOList;
}
