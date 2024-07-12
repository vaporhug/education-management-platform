package com.fjxgwzd.teacherresourcesharing.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fjxgwzd.teacherresourcesharing.entity.CourseInst;
import com.fjxgwzd.teacherresourcesharing.mapper.ChapterMapper;
import com.fjxgwzd.teacherresourcesharing.minio.MinioProperties;
import com.fjxgwzd.teacherresourcesharing.service.CourseService;
import com.fjxgwzd.teacherresourcesharing.vo.ChapterVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseDetalVO;
import com.fjxgwzd.teacherresourcesharing.vo.CourseInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Service;

import java.time.Year;
import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    private ChapterMapper chapterMapper;

    @Override
    public String coursesInfo(String teacherId) throws JsonProcessingException {
        // 根据userId查询对应的课程号
        // 对检索到的所有课程号进行时间的鉴定
        // 鉴定是否为当学期所授课程
        List<CourseInfoVO> courseInstsInfo = chapterMapper.findCourseInstByTeacherId(teacherId, Year.now().getValue());
        // 将其转化为json格式的String文本
        ObjectMapper objectMapper = new ObjectMapper();
        String result = objectMapper.writeValueAsString(courseInstsInfo);
        System.out.println(result);
        return result;
    }

    @Override
    public String courseDetailsInfo(Integer courseInstId) throws JsonProcessingException {
        //  通过courseId查询到所有对应的信息，存储在courseVO当中
        List<ChapterVO> courseDetalByCourseInstId = chapterMapper.findCourseDetalByCourseInstId(courseInstId);
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(courseDetalByCourseInstId);
    }
}
