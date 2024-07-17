package com.fjxgwzd.undergraduateacademicadministration.vo;

import java.util.Date;

public class ExamSchedVo {
    Integer courseInstId;
    String courseName;
    Integer week;
    Integer dayOfWeek;
    Integer periodFrom;
    String campusName;
    String building;
    String classRoomName;
    String assessMethod;

    public String getClassRoomName() {
        return classRoomName;
    }

    public void setClassRoomName(String classRoomName) {
        this.classRoomName = classRoomName;
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


    public Integer getCourseInstId() {
        return courseInstId;
    }

    public void setCourseInstId(Integer courseInstId) {
        this.courseInstId = courseInstId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCampusName() {
        return campusName;
    }

    public void setCampusName(String campusName) {
        this.campusName = campusName;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }



    public String getAssessMethod() {
        return assessMethod;
    }

    public void setAssessMethod(String assessMethod) {
        this.assessMethod = assessMethod;
    }


}
