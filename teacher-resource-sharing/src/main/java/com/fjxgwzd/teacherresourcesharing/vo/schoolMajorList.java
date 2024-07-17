package com.fjxgwzd.teacherresourcesharing.vo;

import lombok.Data;

import java.util.List;

@Data
public class schoolMajorList {
    private Short schoolId;
    private String schoolName;
    private List<MajorVO> majors;
}
