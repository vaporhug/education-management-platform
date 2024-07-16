package com.fjxgwzd.teachersystemmanagement.service.impl;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fjxgwzd.teachersystemmanagement.vo.*;
import com.fjxgwzd.teachersystemmanagement.entity.Semester;
import org.springframework.beans.factory.annotation.Autowired;
import com.fjxgwzd.teachersystemmanagement.mapper.TeacherMapper;
import com.fjxgwzd.teachersystemmanagement.service.TeacherService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.chrono.ChronoLocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TeacherInfoImpl implements TeacherService {
    @Autowired
    TeacherMapper teacherMapper;

    @Override
    public TeacherDetailInfoVO getTeacherDetailInfo(String teacherId) {
        TeacherDetailInfoVO teacherDetailInfoVO = teacherMapper.getTeacherDetailInfoByTeacherId(teacherId);

        teacherDetailInfoVO.setBachelor(changeBachelor(teacherDetailInfoVO.getBachelor()));
        teacherDetailInfoVO.setType(changeTeacherType(teacherDetailInfoVO.getType()));
        teacherDetailInfoVO.setTitle(changeTeacherTitle(teacherDetailInfoVO.getTitle()));

        List<EduExpVO> eduExpVOS = teacherMapper.getEduExpByTeacherId(teacherId);
        for (EduExpVO eduExpVO : eduExpVOS) {
            eduExpVO.setBachelor(changeTeacherType(eduExpVO.getBachelor()));
        }
        teacherDetailInfoVO.setEduExpList(eduExpVOS);
        return teacherDetailInfoVO;
    }

    @Override
    public TeacherResearchFindings teacherResearchFindings(String teacherId,Integer type, Integer offset, Integer num) {
        // 由offset为开始
        // num为获取总数
        List<TeacherResearchFinding> teacherResearchFindingList = teacherMapper.getTeacherResearchFindingsByTeacherId(teacherId,type,offset,num);
        TeacherResearchFindings teacherResearchFindings = new TeacherResearchFindings();
        teacherResearchFindings.setTeacherResearchFindings(teacherResearchFindingList);
        // 获取总数，此时暂时使用每次都计算
        teacherResearchFindings.setSum(teacherMapper.getTeacherResearchFindingsCountByTeacherId(teacherId, type)/num);
        return teacherResearchFindings;
    }
    public String changeBachelor(String bachelorId) {
        Map<String, String> bachelorMap = new HashMap<>();
        bachelorMap.put("1", "学士学位");
        bachelorMap.put("2", "硕士学位");
        bachelorMap.put("3", "博士学位");
        String bachelorDescription = bachelorMap.getOrDefault(bachelorId, "未知学位");
        return bachelorDescription;
    }

    public String changeTeacherType(String schoolId) {
        Map<String, String> TeacherTypeMap = new HashMap<>();
        TeacherTypeMap.put("1", "专职教师");
        TeacherTypeMap.put("2", "校内兼职教师");
        TeacherTypeMap.put("3", "校外兼职教师");
        String TeacherTypeDescription = TeacherTypeMap.getOrDefault(schoolId, "未知职位");
        return TeacherTypeDescription;
    }

    public String changeTeacherTitle(String schoolId) {
        Map<String, String> TeacherTitleMap = new HashMap<>();
        TeacherTitleMap.put("1", "讲师");
        TeacherTitleMap.put("2", "副教授");
        TeacherTitleMap.put("3", "正教授");
        String TeacherTitleDescription = TeacherTitleMap.getOrDefault(schoolId, "未知职称");
        return TeacherTitleDescription;
    }

    @Override
    public List<CourseTaskVO> getCourseTaskByTeacherId(String teacherId, Integer year, boolean termPart, Integer week) throws JsonProcessingException {
        return teacherMapper.getCourseTaskByTeacherId(teacherId,year,termPart,week);
    }

    @Override
    public DefaultCourseTableVO getDefaultCourseTableByTeacherId(String teacherId) throws Exception {
        // 1、根据LocalDateTime获取当前学期
        LocalDateTime currentTime = LocalDateTime.now();
        LocalDate currentDate = currentTime.toLocalDate();
        // 1.1、由年份先判断应该是哪个学期
        Integer currentYear = currentDate.getYear();
        List<Semester> semesters = List.of();
        List<Semester> semesterList = teacherMapper.getAllSemester();
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
        List<CourseTaskVO> courseTaskVOList = teacherMapper.getCourseTaskByTeacherId(teacherId,currentSemester.getYear(), currentSemester.isTerm_part(), week);
        defaultCourseTableVO.setCourseTasks(courseTaskVOList);
        return defaultCourseTableVO;
    }

    public int getWeekNumber(LocalDate startDate, LocalDate endDate) {
        // 计算从起始日期到当前日期的天数
        long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
        // 计算周数
        int weekNumber = (int) (daysBetween / 7) + 1; // +1 是因为第1天就算第1周

        return weekNumber;
    }

    @Override
    public TotalTeacherDetailVO getTotalTeacherDetail(Short schoolId, Short majorId, String title, String name, boolean gender, Integer offset, Integer num) {
        TotalTeacherDetailVO totalTeacherDetailVO = new TotalTeacherDetailVO();
        totalTeacherDetailVO.setSum(teacherMapper.getSum(schoolId,majorId,title,name,gender));
        List<TeacherDetailInfoVO> teacherDetailInfoVOList = teacherMapper.getTotalTeacherDetailInfo(schoolId,majorId,title,name,gender,offset,num);
        for (TeacherDetailInfoVO teacherDetailInfoVO : teacherDetailInfoVOList) {
            teacherDetailInfoVO.setBachelor(changeBachelor(teacherDetailInfoVO.getBachelor()));
            teacherDetailInfoVO.setType(changeTeacherType(teacherDetailInfoVO.getType()));
            teacherDetailInfoVO.setTitle(changeTeacherTitle(teacherDetailInfoVO.getTitle()));
            List<EduExpVO> eduExpVOS = teacherMapper.getEduExpByTeacherId(teacherDetailInfoVO.getTeacherId());
            for (EduExpVO eduExpVO : eduExpVOS) {
                eduExpVO.setBachelor(changeTeacherType(eduExpVO.getBachelor()));
            }
            teacherDetailInfoVO.setEduExpList(eduExpVOS);
        }
        totalTeacherDetailVO.setTeacherDetailVOList(teacherDetailInfoVOList);
        return totalTeacherDetailVO;
    }

    @Override
    public String uploadGrades(String courseInstId, GradeVO[] stuScores) {
//        Integer courseSecId = teacherMapper.getCourseSecId(Integer.valueOf(courseInstId));
        for(int i = 0; i< stuScores.length;i++){
            Short status = 1;
            if(stuScores[i].getTotalScore()>60){
                status = 2;
            }else {
                status = 3;
            }
            teacherMapper.insertScores(stuScores[i].getStuId(), Integer.valueOf(courseInstId),stuScores[i].getTotalScore(),status);
        }
        return "录入成功";
    }
}
