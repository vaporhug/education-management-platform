package com.fjxgwzd.undergraduateacademicadministration.vo;

import lombok.Data;

public class AttendanceStudentVO {
    public Integer getWeek() {
        return week;
    }

    public void setWeek(Integer week) {
        this.week = week;
    }

    public Integer getSum() {
        return sum;
    }

    public void setSum(Integer sum) {
        this.sum = sum;
    }

    private Integer week;
    private Integer sum;
}
