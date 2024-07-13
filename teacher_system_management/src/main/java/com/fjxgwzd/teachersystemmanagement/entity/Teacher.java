package com.fjxgwzd.teachersystemmanagement.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Teacher {
    private String id;
    private String name;
    private LocalDateTime hireDate;
    private String phone;
    private Short type;
    private Short gender;
    private Short majorId;
    private Short SchoolId;
    private Short title;
    private Short bachelor;
    private String email;
    private String description;
    private String researchFocus;
    private Long teacherId;
    private String identity;
    private String address;
}
