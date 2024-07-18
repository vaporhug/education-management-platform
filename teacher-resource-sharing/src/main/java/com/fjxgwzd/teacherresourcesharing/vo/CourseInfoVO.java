package com.fjxgwzd.teacherresourcesharing.vo;

import lombok.Data;

@Data
public class CourseInfoVO {
    // 传这个课程实体的id号，而不是其他id号
    private Integer courseInstId;
    // 传课程名称
    private String name;
    // 课程类型，必修选修，全校性
    private String courseType;
    private String courseCate;
    private String courseFor;
    // 课程学分
    private Integer credit;
    private Integer gradeLevel;
    private Integer schoolId;
    private String schoolName;
    private String coursePic;
    private Integer year;
    private boolean termPart;
    private Integer totalClassHour;
}
