package com.fjxgwzd.academicmanagement.vo;


import lombok.Data;

@Data
public class ExamScoreVO {
    private Integer year;
    private Boolean termPart;
    private Integer courseInstId;
    private String courseName;
    private Integer score;
    private Integer credit;
    private String courseType;
    private String courseCate;
}
