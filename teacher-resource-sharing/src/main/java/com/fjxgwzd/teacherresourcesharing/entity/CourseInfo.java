package com.fjxgwzd.teacherresourcesharing.entity;

import com.fjxgwzd.teacherresourcesharing.vo.CourseInfoVO;
import lombok.Data;

import java.util.List;

@Data
public class CourseInfo {
    private List<CourseInfoVO> courses;
}
