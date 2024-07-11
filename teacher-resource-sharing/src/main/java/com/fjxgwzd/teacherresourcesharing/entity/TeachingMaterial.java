package com.fjxgwzd.teacherresourcesharing.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class TeachingMaterial {
    private Integer id;
    private Integer forChapter;
    private LocalDateTime createTime;
    private String uploader_id;
    private String name;
    private Integer file_id;
}
