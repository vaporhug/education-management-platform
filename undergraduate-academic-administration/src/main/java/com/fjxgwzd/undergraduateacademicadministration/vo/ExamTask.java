package com.fjxgwzd.undergraduateacademicadministration.vo;

public class ExamTask {
    Integer courseInstId;
    String courseName;
    Integer week;
    Integer dayOfWeek;
    Integer periodFrom;
    String classRoomName;
    Integer seatNumber;
    String stuId;
    String assessMethod;
    String building;

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

    public String getClassRoomName() {
        return classRoomName;
    }

    public void setClassRoomName(String classRoomName) {
        this.classRoomName = classRoomName;
    }

    public Integer getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(Integer seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }

    public String getAssessMethod() {
        return assessMethod;
    }

    public void setAssessMethod(String assessMethod) {
        this.assessMethod = assessMethod;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }
}
