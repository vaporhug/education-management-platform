package com.fjxgwzd.undergraduateacademicadministration.entity;

import lombok.Data;

@Data
public class Course {
    private String id;
    private String name;
    private Short courseType;
    private Short courseCate;
    private Short courseFor;
    private Short credit;
    private Short gradeLevel;
    private Long coursePic;
}
