package com.fjxgwzd.teacherresourcesharing.entity;

import lombok.Data;

@Data
public class CourseInst {
    private Integer id;
    private String courseId;
    private Integer year;
    private boolean termPart;
    private String instructorMsg;
    private String overview;
    private Short accessMethod;
    private String methodDetal;
}
