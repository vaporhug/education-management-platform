package com.fjxgwzd.teachersystemmanagement.vo;

import lombok.Data;
import java.util.List;
@Data
public class CourseTaskResponse {
    private List<CourseTaskVO> course_tasks;

    public CourseTaskResponse(List<CourseTaskVO> course_tasks) {
        this.course_tasks = course_tasks;
    }

    public List<CourseTaskVO> getCourse_tasks() {
        return course_tasks;
    }

    public void setCourse_tasks(List<CourseTaskVO> course_tasks) {
        this.course_tasks = course_tasks;
    }
}
