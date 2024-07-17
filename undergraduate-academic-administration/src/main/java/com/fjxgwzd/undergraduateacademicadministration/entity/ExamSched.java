package com.fjxgwzd.undergraduateacademicadministration.entity;

import java.io.Serializable;

/**
 * (ExamSched)实体类
 *
 * @author makejava
 * @since 2024-07-18 02:54:01
 */
public class ExamSched implements Serializable {
    private static final long serialVersionUID = -66560916715397105L;
    
    private Integer id;
    
    private Integer courseInstId;
    
    private Integer duration;
    
    private Integer classroomId;
    
    private Integer year;
    
    private Integer termPart;
    
    private Integer week;
    
    private Integer dayOfWeek;
    
    private Integer periodFrom;
    
    private Integer periodTo;
    /**
     * 普通考试，补考，重修考试...
     */
    private Integer type;
    
    private Integer originalExamSched;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCourseInstId() {
        return courseInstId;
    }

    public void setCourseInstId(Integer courseInstId) {
        this.courseInstId = courseInstId;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Integer getClassroomId() {
        return classroomId;
    }

    public void setClassroomId(Integer classroomId) {
        this.classroomId = classroomId;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getTermPart() {
        return termPart;
    }

    public void setTermPart(Integer termPart) {
        this.termPart = termPart;
    }

    public Integer getWeek() {
        return week;
    }

    public void setWeek(Integer week) {
        this.week = week;
    }

    public Integer getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(Integer dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public Integer getPeriodFrom() {
        return periodFrom;
    }

    public void setPeriodFrom(Integer periodFrom) {
        this.periodFrom = periodFrom;
    }

    public Integer getPeriodTo() {
        return periodTo;
    }

    public void setPeriodTo(Integer periodTo) {
        this.periodTo = periodTo;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getOriginalExamSched() {
        return originalExamSched;
    }

    public void setOriginalExamSched(Integer originalExamSched) {
        this.originalExamSched = originalExamSched;
    }

}

