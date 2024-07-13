package com.fjxgwzd.teacherresourcesharing.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teacherresourcesharing.vo.ChapterVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseDetalVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseInfoVO;

import java.util.List;

public interface CourseService {
    List<CourseInfoVO> coursesInfo(String teacherId, Integer year, boolean termPart) throws JsonProcessingException;
}
