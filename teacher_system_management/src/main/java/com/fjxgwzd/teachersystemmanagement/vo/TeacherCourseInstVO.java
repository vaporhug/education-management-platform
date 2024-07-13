package com.fjxgwzd.teachersystemmanagement.vo;

import lombok.Data;

@Data
public class TeacherCourseInstVO {
    private String courseInstId;
    private String name;
    private String courseType;
    private String courseCate;
    private String courseFor;
    private Integer credit;
    private Integer gradeLevel;
    private Integer schoolId;
    private String schoolName;
    private String coursePic;
    private Integer year;
    private boolean termPart;
    private Integer totalClassHour;
}
