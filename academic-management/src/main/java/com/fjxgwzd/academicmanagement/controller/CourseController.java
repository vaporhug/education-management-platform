package com.fjxgwzd.academicmanagement.controller;

import com.fjxgwzd.academicmanagement.entity.Course;
import com.fjxgwzd.academicmanagement.entity.CourseInst;
import com.fjxgwzd.academicmanagement.entity.CourseInstSection;
import com.fjxgwzd.academicmanagement.entity.School;
import com.fjxgwzd.academicmanagement.service.ArchitectureService;
import com.fjxgwzd.academicmanagement.service.CourseService;
import com.fjxgwzd.common.result.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class CourseController {
    @Autowired
    private CourseService courseService;
    @Autowired
    private ArchitectureService architectureService;
    @PostMapping("/courseSection")
    public Result<Object> courseSection(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
        try{
            List<String> courseInstSectionIds = courseService.getCourseInstSectionsIdsByStudentId(primaryInfo);
            Integer yearBegin = Integer.MAX_VALUE;
            Integer yearEnd = Integer.MIN_VALUE;
            Map<String,Object> data = new HashMap<>();
            Map<String,Object> dataValueItem  = null;
            List<Map<String,Object>> dataValue = new ArrayList<>();
            for (String courseInstSectionId : courseInstSectionIds) {
                CourseInstSection courseInstSection = courseService.getCourseInstSectionById(Integer.parseInt(courseInstSectionId));
                CourseInst courseInst = courseService.getCourseInstById(courseInstSection.getCourseInstId());
                Course course = courseService.getCoursesByCourseId(courseInst.getCourseId());
                dataValueItem = new HashMap<>();
                dataValueItem.put("courseInstId",courseInst.getId());
                List<CourseInstSection> courseInstSections =  courseService.getCourseInstSectionsByCourseInstId(courseInst.getId());
                dataValueItem.put("courseInstSections",courseInstSections);
                dataValueItem.put("name",course.getName());
                dataValueItem.put("courseType",course.getCourseType());
                dataValueItem.put("courseCate",course.getCourseCate());
                dataValueItem.put("courseFor",course.getCourseFor());
                dataValueItem.put("credit",course.getCredit());
                dataValueItem.put("gradeLevel",course.getGradeLevel());
                dataValueItem.put("schoolId",course.getSchoolId());
                School school = null;
                try{
                    school = architectureService.findSchoolById(course.getSchoolId());
                }catch (Exception e){
                    e.printStackTrace();
                    return Result.fail();
                }
                dataValueItem.put("schoolName",school.getName());
                dataValueItem.put("coursePic",course.getCoursePic());
                Integer year = courseInst.getYear();
                if (year < yearBegin){
                    yearBegin = year;
                }
                if (year > yearEnd){
                    yearEnd = year;
                }
                dataValueItem.put("year",year);
                dataValueItem.put("termPart",courseInst.getTermPart());
                dataValueItem.put("totalClassHour",courseInst.getTotalClassHour());
                dataValue.add(dataValueItem);
            }
            data.put("yearBegin",yearBegin);
            data.put("yearEnd",yearEnd);
            data.put("nowYear",Year.now().getValue());
            int monthValue = LocalDate.now().getMonthValue();
            data.put("nowTermPart",(monthValue >= 2 && monthValue <= 7) ? 0 : 1);
            data.put("courses",dataValue);
            return Result.ok();
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
    }

    @PostMapping("/courseTeach")
    public Result<Object> courseTeach(@RequestHeader("PrimaryInfo") String primaryInfo, @RequestBody Map<String, Object> conditions) {
        List<String> courseIds = null;
        List<Course> courses = null;
        List<CourseInst> courseInsts = null;
        try{
            courseIds = courseService.getCourseIdsByTeacherId(primaryInfo);
            courses = courseService.getCoursesByCourseIds(courseIds);
            courseInsts = courseService.getCourseInstsByCourseIds(courseIds);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail();
        }
        Integer yearBegin = Integer.MAX_VALUE;
        Integer yearEnd = Integer.MIN_VALUE;
        Map<String,Object> data = new HashMap<>();
        List<Map<String,Object>> dataValue = new ArrayList<>();
        Map<String,Course> courseId2Course = new HashMap<>();
        for (Course course : courses){
            courseId2Course.put(course.getId(),course);
        }
        Map<String,Object> dataValueItem  = null;
        for (CourseInst courseInst :courseInsts){
            dataValueItem = new HashMap<>();
            dataValueItem.put("courseInstId",courseInst.getId());
            List<CourseInstSection> courseInstSections =  courseService.getCourseInstSectionsByCourseInstId(courseInst.getId());
            dataValueItem.put("courseInstSections",courseInstSections);
            Course course = courseId2Course.get(courseInst.getCourseId());
            dataValueItem.put("name",course.getName());
            dataValueItem.put("courseType",course.getCourseType());
            dataValueItem.put("courseCate",course.getCourseCate());
            dataValueItem.put("courseFor",course.getCourseFor());
            dataValueItem.put("credit",course.getCredit());
            dataValueItem.put("gradeLevel",course.getGradeLevel());
            dataValueItem.put("schoolId",course.getSchoolId());
            School school = null;
            try{
                school = architectureService.findSchoolById(course.getSchoolId());
            }catch (Exception e){
                e.printStackTrace();
                return Result.fail();
            }
            dataValueItem.put("schoolName",school.getName());
            dataValueItem.put("coursePic",course.getCoursePic());
            Integer year = courseInst.getYear();
            if (year < yearBegin){
                yearBegin = year;
            }
            if (year > yearEnd){
                yearEnd = year;
            }
            dataValueItem.put("year",year);
            dataValueItem.put("termPart",courseInst.getTermPart());
            dataValueItem.put("totalClassHour",courseInst.getTotalClassHour());
            dataValue.add(dataValueItem);
        }

        data.put("yearBegin",yearBegin);
        data.put("yearEnd",yearEnd);
        data.put("nowYear",Year.now().getValue());
        int monthValue = LocalDate.now().getMonthValue();
        data.put("nowTermPart",(monthValue >= 2 && monthValue <= 7) ? 0 : 1);
        data.put("courses",dataValue);
        return Result.ok(data);
    }
}
