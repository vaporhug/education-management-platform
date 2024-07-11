package com.fjxgwzd.teacherresourcesharing.entity;

import lombok.Data;

@Data
public class CourseSched {
    private Integer id;
    private Short week;
    private Short periodFrom;
    private Short periodTo;
    private Integer courseSection;
    private Short dayOfWeek;
    private Integer classroomId;
    private Integer year;
    private boolean termPart;
    private Short teacherAttend;
    private String courseLog;
}
