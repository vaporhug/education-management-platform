package com.fjxgwzd.undergraduateacademicadministration.vo;

import lombok.Data;

import java.util.List;

@Data
public class CourseStudentVO {
    private Integer studentSum;
    private List<StudentVO> studentVOList;
}
