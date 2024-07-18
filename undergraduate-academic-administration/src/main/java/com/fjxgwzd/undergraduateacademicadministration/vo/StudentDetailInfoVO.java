package com.fjxgwzd.undergraduateacademicadministration.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class StudentDetailInfoVO {
    private String picUrl;
    private String name;
    private boolean gender;
    private String stuId;
    private String phoneNumber;
    private Integer majorId;
    private String majorName;
    private LocalDateTime birthday;
    private String address;
    private Integer schoolId;
    private String schoolName;
    private Integer gradeLevel;
    private String identity;
    private Integer startYear;
}
