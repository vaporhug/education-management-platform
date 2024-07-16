package com.fjxgwzd.teachersystemmanagement.vo;

import lombok.Data;

@Data
public class RecordVO {
    private Integer recordId;
    private Integer year;
    private boolean termPart;
    private Integer week;
    private Integer dayOfWeek;
    private Integer periodFrom;
    private Integer periodTo;
    private ClassroomInfo classroomInfo;
    private Integer result;
    private String actName;
    private Integer reason;
    private String reasonDetail;
}
