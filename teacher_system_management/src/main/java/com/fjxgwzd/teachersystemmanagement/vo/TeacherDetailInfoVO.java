package com.fjxgwzd.teachersystemmanagement.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class TeacherDetailInfoVO {
    private String teacherId;
    private String teacherName;
    private String phone;
    private LocalDateTime hireDate;
    private String type;
    private boolean gender;
    private Integer schoolId;
    private String schoolName;
    private Integer majorId;
    private String majorName;
    private String title;
    private String bachelor;
    private String email;
    private String description;
    private String researchFocus;
    private String picUrl;
    private String address;
    private Integer aaoOfficeId;
    private String aaoOfficeName;
    private String identity;
    private List<EduExpVO> eduExpList;
}
