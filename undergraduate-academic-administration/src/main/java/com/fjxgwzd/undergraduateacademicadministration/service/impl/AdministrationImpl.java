package com.fjxgwzd.undergraduateacademicadministration.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.undergraduateacademicadministration.entity.Semester;
import com.fjxgwzd.undergraduateacademicadministration.mapper.StudentIdMapper;
import com.fjxgwzd.undergraduateacademicadministration.service.AdministrationService;
import com.fjxgwzd.undergraduateacademicadministration.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.chrono.ChronoLocalDate;
import java.util.List;
import java.time.temporal.ChronoUnit;

@Service
public class AdministrationImpl implements AdministrationService {
    @Autowired
    StudentIdMapper studentIdMapper;

    @Override
    public EducationPlanVO getEducationPlanByMajorId(Short majorId, Short cohortYear) throws JsonProcessingException {
        EducationPlanVO educationPlanVO = studentIdMapper.getEducationPlanByMajorId(majorId,cohortYear);
        return educationPlanVO;
    }

    @Override
    public StudentDetailInfoVO getStudentDetailInfoByStudentId(String studentId) throws JsonProcessingException {
        StudentDetailInfoVO studentDetailInfoVO = studentIdMapper.getStudentDetailInfoByStudentId(studentId);
        return studentDetailInfoVO;
    }

    //    @Override
//    public EducationPlanVO getEducationPlanByMajorId(Short majorId) throws JsonProcessingException {
//        EducationPlanVO educationPlanVO = studentIdMapper.getEducationPlanByMajorId(majorId, cohortYear);
//        return educationPlanVO;
////        ObjectMapper objectMapper = new ObjectMapper();
////        objectMapper.setSerializationInclusion(JsonInclude.Include.ALWAYS);
//////        System.out.println(educationPlanVO.getCourseNames());
//////        System.out.println(educationPlanVO.getCoreCourseIds());
//////        System.out.println(educationPlanVO.getCreditReqNames());
//////        System.out.println(educationPlanVO.getCreditReqTotals());
////        return objectMapper.writeValueAsString(educationPlanVO);
//    }


    @Override
    public DefaultCourseTableVO getDefaultCourseTableByStudentId(String studentId) throws Exception {
        // 1、根据LocalDateTime获取当前学期
        LocalDateTime currentTime = LocalDateTime.now();
        LocalDate currentDate = currentTime.toLocalDate();
        // 1.1、由年份先判断应该是哪个学期
        Integer currentYear = currentDate.getYear();
        List<Semester> semesters = List.of();
        List<Semester> semesterList = studentIdMapper.getAllSemester();
        for (Semester semester : semesterList) {
            if (semester.getYear() == currentYear) {
                semesters.add(semester);
            }
        }
        // 1.2、根据当前时间，获取学期
        // 2、将当前学期的起始周获取，计算当前week
        int week = 1;

        Semester currentSemester = null;
        if(currentDate.isBefore(ChronoLocalDate.from(semesterList.get(0).getFrom_date()))){
            // 小于第一个
            currentSemester = semesterList.get(0);
            week = 1;
        }
        else if (currentDate.isBefore(ChronoLocalDate.from(semesterList.get(1).getTo_date()))){
            currentSemester = semesterList.get(1);
            if(currentDate.isBefore(ChronoLocalDate.from(semesterList.get(1).getTo_date()))){
                week = 1;
            }else {
                week = getWeekNumber(LocalDate.from(currentSemester.getFrom_date()),currentDate);
            }
        }else {
            for(int i =0; i < semesterList.size(); i++){
                if(semesterList.get(i).equals(semesterList.get(1))){
                    if(i+1 < semesterList.size()){
                        currentSemester = semesterList.get(i+1);
                        week = 1;
                        break;
                    }else {
                        throw new Exception();
                    }
                }
            }
        }
        // 3、将默认的课表的主要信息填充返回
        DefaultCourseTableVO defaultCourseTableVO = new DefaultCourseTableVO();
        defaultCourseTableVO.setYearBegin(semesterList.get(0).getYear());
        defaultCourseTableVO.setNowTermPart(currentSemester.isTerm_part());
        defaultCourseTableVO.setNowWeek(week);
        // 4、查询当前年、学期、周下学生对应的课表，插入到其中
        List<CourseTaskVO> courseTaskVOList = studentIdMapper.getCourseTaskByStudentId(studentId,currentSemester.getYear(), currentSemester.isTerm_part(), week);
        defaultCourseTableVO.setCourseTasks(courseTaskVOList);
        return defaultCourseTableVO;
    }

    @Override
    public List<CourseTaskVO> getCourseTaskByStudentId(String studentId , Integer year, boolean termPart, Integer week) throws JsonProcessingException {
        return studentIdMapper.getCourseTaskByStudentId(studentId,year,termPart,week);
    }

    public int getWeekNumber(LocalDate startDate, LocalDate endDate) {
        // 计算从起始日期到当前日期的天数
        long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
        // 计算周数
        int weekNumber = (int) (daysBetween / 7) + 1; // +1 是因为第1天就算第1周

        return weekNumber;
    }

    @Override
    public TotalStudentDetailVO getTotalStudentDetail(Short schoolId, Short majorId, Integer startYear, Integer classId, Boolean gender, String name, Integer offset, Integer num) throws JsonProcessingException {
        TotalStudentDetailVO totalStudentDetailVO = new TotalStudentDetailVO();
        totalStudentDetailVO.setSum(studentIdMapper.getSum(schoolId,majorId,startYear,classId,gender,name)/num);
        List<StudentDetailInfoVO> studentDetailInfoVOList = studentIdMapper.getTotalStudentDetail(schoolId,majorId,startYear,classId,gender,name,offset,num);
        totalStudentDetailVO.setStudentDetailInfoVOList(studentDetailInfoVOList);
        return totalStudentDetailVO;
    }
}
