package com.fjxgwzd.undergraduateacademicadministration.vo;

import java.util.List;

public class ProctorExamVo {
    Integer year;
    Boolean termPart;
    List<ExamSchedVo> exams;

    public Boolean getTermPart() {
        return termPart;
    }

    public void setTermPart(Boolean termPart) {
        this.termPart = termPart;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }



    public List<ExamSchedVo> getExams() {
        return exams;
    }

    public void setExams(List<ExamSchedVo> exams) {
        this.exams = exams;
    }
}
