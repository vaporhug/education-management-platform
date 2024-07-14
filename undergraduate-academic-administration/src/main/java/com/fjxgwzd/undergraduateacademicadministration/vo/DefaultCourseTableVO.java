package com.fjxgwzd.undergraduateacademicadministration.vo;

import lombok.Data;

import java.util.List;

@Data
public class DefaultCourseTableVO {
    private Integer yearBegin;
    private boolean nowTermPart;
    private Integer nowWeek;
    private List<CourseTaskVO> courseTasks;
}
