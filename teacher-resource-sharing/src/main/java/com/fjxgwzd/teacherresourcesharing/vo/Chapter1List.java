package com.fjxgwzd.teacherresourcesharing.vo;

import lombok.Data;

import java.util.List;

@Data
public class Chapter1List {
    private Integer chapter1Id;
    private String chapter1Name;
    private List<ChapterVO> chapter2List;
}
