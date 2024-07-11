package com.fjxgwzd.teacherresourcesharing.vo;

import lombok.Data;

@Data
public class CourseInfoVO {
    // 传这个课程实体的id号，而不是其他id号
    private Integer courseInstId;
    // 传课程名称
    private String name;
    // 课程类型，必修选修，全校性
    private Short courseType;
    // 课程学分
    private Short credit;
    // 指导教师
    private String instructorMsg;
    // 开课周期
    private Integer year;
    private boolean termPart;
    // 年级
    private Short gradeLevel;

    // 课程信息
    private Short courseCate;
    private Short courseFor;

    // 实体班名
    private String courseInstName;
}
