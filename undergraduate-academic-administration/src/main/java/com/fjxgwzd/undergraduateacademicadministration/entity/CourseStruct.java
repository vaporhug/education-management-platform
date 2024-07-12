package com.fjxgwzd.undergraduateacademicadministration.entity;

import lombok.Data;

@Data
public class CourseStruct {
    private Integer id;
    private Short forMajor;
    private Short cohortYear;
    private Short cate;
    private Short subcate;
    private String courseName;
    private Short courseType;
    private Short credit;
    private Short hours;
}
