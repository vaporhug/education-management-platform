package com.fjxgwzd.teacherresourcesharing.entity;

import lombok.Data;

@Data
public class File {
    private Integer id;
    private String url;
    private Long size;
    private String hash;
}
