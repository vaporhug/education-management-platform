package com.fjxgwzd.teachersystemmanagement.vo;

import lombok.Data;

@Data
public class CourseTaskVO {
    private Integer courseInstSectionId;
    private String courseInstId;
    private String courseName;
    private String[] courseTeacherName;
    private String classroomName;
    private Integer dayOfWeek;
    private Integer periodFrom;
    private Integer periodTo;

    public void setCourseTeacherName(String courseTeacherName) {
        if(courseTeacherName!=null && ! courseTeacherName.isEmpty()){
            this.courseTeacherName = courseTeacherName.split(",");
        }
        else {
            this.courseTeacherName = new String[0];
        }
    }
}
