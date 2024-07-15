package com.fjxgwzd.undergraduateacademicadministration.vo;

import lombok.Data;

@Data
public class EducationPlanVO {
    // 课程名
    private String majorName;
    private String time;
    private Integer aaoOfficeId;
    private String aaoOfficeName;
    private Integer schoolId;
    private String schoolName;
    private String degreeName;
    private Integer duration;
    private Integer maxDuration;
    private Integer minDuration;
    private String description;
    private String target;
    private String req;

    private Integer[] coreCourseIds; // Change to String
    private String[] courseNames; // Change to String
    private String[] creditReqNames; // Change to String
    private Integer[] creditReqTotals; // Change to String

    public void setCoreCourseIds(String coreCourseIds) {
        if (coreCourseIds != null && ! coreCourseIds.isEmpty()) {
            String[] coreCourseIdArray = coreCourseIds.split(",");
            this.coreCourseIds = new Integer[coreCourseIdArray.length];
            for (int i = 0; i < coreCourseIdArray.length; i++)
                this.coreCourseIds[i] = Integer.parseInt(coreCourseIdArray[i].trim());
        }else {
            this.coreCourseIds = null;
        }
    }

    public void setCourseNames(String courseNames) {
        if(courseNames != null && ! courseNames.isEmpty()){
            this.courseNames = courseNames.split(",");
        }else {
            this.courseNames = new String[0];
        }
    }
    public void setCreditReqNames(String creditReqNames) {
        if(creditReqNames != null && !creditReqNames.isEmpty()) {
            this.creditReqNames = creditReqNames.split(",");
        }else {
            this.creditReqNames = new String[0];
        }
    }

    public void setCreditReqTotals(String creditReqTotals) {
        if (creditReqTotals != null && ! creditReqTotals.isEmpty()) {
            String[] creditReqTotalArray = creditReqTotals.split(",");
            this.creditReqTotals = new Integer[creditReqTotalArray.length];
            for (int i = 0; i < creditReqTotalArray.length; i++)
                this.creditReqTotals[i] = Integer.parseInt(creditReqTotalArray[i].trim());
        }else {
            this.creditReqTotals = null;
        }
    }
}
