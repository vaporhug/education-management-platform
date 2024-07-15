package com.fjxgwzd.teacherresourcesharing.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teacherresourcesharing.mapper.ChapterMapper;
import com.fjxgwzd.teacherresourcesharing.service.CourseService;
import com.fjxgwzd.teacherresourcesharing.vo.CourseInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    private ChapterMapper chapterMapper;

//    @Override
//    public List<CourseInfoVO> coursesInfo(String teacherId) throws JsonProcessingException {
//        // 根据userId查询对应的课程号
//        // 对检索到的所有课程号进行时间的鉴定
//        // 鉴定是否为当学期所授课程
//        List<CourseInfoVO> courseInstsInfo = chapterMapper.findCourseInstByTeacherId(teacherId, Year.now().getValue());
//        // 将其转化为json格式的String文本
////        ObjectMapper objectMapper = new ObjectMapper();
////        String result = objectMapper.writeValueAsString(courseInstsInfo);
////        System.out.println(result);
//        return courseInstsInfo;
//    }


    @Override
    public List<CourseInfoVO> coursesInfo(String teacherId, Integer year, boolean termPart) throws JsonProcessingException {
        List<CourseInfoVO> courseInstsInfo = chapterMapper.findCourseInstByTeacherId(teacherId, year, termPart);
        for (CourseInfoVO courseInfoVO : courseInstsInfo) {
            courseInfoVO.setCourseCate(changeCourseCate(courseInfoVO.getCourseCate()));
            courseInfoVO.setCourseType(changeCourseType(courseInfoVO.getCourseType()));
            courseInfoVO.setCourseFor(changeCourseFor(courseInfoVO.getCourseFor()));
        }
        return courseInstsInfo;
    }

    public String changeCourseType(String schoolId) {
        Map<String, String> CourseTypeMap = new HashMap<>();
        CourseTypeMap.put("1", "全校性选修课");
        CourseTypeMap.put("2", "专业必修课");
        CourseTypeMap.put("3", "专业选修课");
        String CourseTypeDescription = CourseTypeMap.getOrDefault(schoolId, "未知课程类型");
        return CourseTypeDescription;
    }

    public String changeCourseCate(String schoolId) {
        Map<String, String> CourseCateMap = new HashMap<>();
        CourseCateMap.put("1", "自然科学类");
        CourseCateMap.put("2", "人文社科类");
        CourseCateMap.put("3", "艺术类");
        CourseCateMap.put("4", "体育类");
        CourseCateMap.put("5", "科研实践类");
        String CourseCateDescription = CourseCateMap.getOrDefault(schoolId, "未知课程类型");
        return CourseCateDescription;
    }

    public String changeCourseFor(String schoolId) {
        Map<String, String> CourseForMap = new HashMap<>();
        CourseForMap.put("1", "软件工程");
        CourseForMap.put("2", "计算机科学与技术");
        CourseForMap.put("3", "信息安全");
        CourseForMap.put("4", "人工智能");
        CourseForMap.put("5", "物联网");
        String CourseForDescription = CourseForMap.getOrDefault(schoolId, "未知专业类型");
        return CourseForDescription;
    }
}
