package com.fjxgwzd.undergraduateacademicadministration.entity;

import lombok.Data;

@Data
public class Student {
    private String id;
    private String name;
    private Short majorId;
    private Short nowLevel;
    private Integer classId;
    private boolean gender;
}
