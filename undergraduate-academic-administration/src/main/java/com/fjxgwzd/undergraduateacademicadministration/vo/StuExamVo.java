package com.fjxgwzd.undergraduateacademicadministration.vo;

import java.util.List;

public class StuExamVo {

    Integer nowYear;
    Boolean nowTermPart;
    List<ExamTask> exams;

    public Integer getNowYear() {
        return nowYear;
    }

    public void setNowYear(Integer nowYear) {
        this.nowYear = nowYear;
    }

    public Boolean getNowTermPart() {
        return nowTermPart;
    }

    public void setNowTermPart(Boolean nowTermPart) {
        this.nowTermPart = nowTermPart;
    }

    public List<ExamTask> getExams() {
        return exams;
    }

    public void setExams(List<ExamTask> exams) {
        this.exams = exams;
    }
}
