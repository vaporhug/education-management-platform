package com.fjxgwzd.teacherresourcesharing.vo;

import com.fjxgwzd.teacherresourcesharing.entity.File;
import lombok.Data;

import java.util.List;

@Data
public class CourseDetalVO {
    // 几几年
    private String courseInstId;
    private String name;
    private String courseType;
    private String courseCate;
    private String courseFor;
    private Integer credit;
    private Integer gradeLevel;
    private Integer schoolId;
    private String schoolName;
    private String coursePic;
    private Integer year;
    private boolean termPart;
    private Integer totalClassTotal;
    private String instructorMsg;
    private String overview;
    private String target;
    private String assessMethod;
    private String methodDetal;
    private Integer maxNum;
    private List<ChapterVO> chapterList;
}
