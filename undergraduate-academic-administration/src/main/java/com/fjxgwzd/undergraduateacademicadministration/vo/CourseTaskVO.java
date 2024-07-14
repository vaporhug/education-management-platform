package com.fjxgwzd.undergraduateacademicadministration.vo;

import lombok.Data;

@Data
public class CourseTaskVO {
    private Integer courseInstSectionId;
    private String courseInstId;
    private String courseName;
    private String courseTeacherName;
    private String classroomName;
    private Integer dayOfWeek;
    private Integer periodFrom;
    private Integer periodTo;
}
