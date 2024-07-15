package com.fjxgwzd.teachersystemmanagement.entity;

import lombok.Data;

@Data
public class ClassroomStatus {
    private Integer id;
    private Integer classroomId;
    private Short year;
    private boolean termPart;
    private Short week;
    private Short dayOfWeek;
    private Short periodFrom;
    private Short periodTo;
    private Short status;
}
