package com.fjxgwzd.teacherresourcesharing.entity;

import lombok.Data;

@Data
public class Chapter {
    private Integer id;
    private String title;
    private Short titleLevel;
    private Integer courseInstId;
}
