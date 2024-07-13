package com.fjxgwzd.undergraduateacademicadministration.vo;

import io.swagger.v3.oas.models.security.SecurityScheme;
import lombok.Data;

import java.util.Arrays;
import java.util.List;

@Data
public class EducationPlanVO {
    // 课程名
    private String major_name;
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
//    private Integer[] coreCourseIds;
//    private String[] courseNames;
//    private String[] creditReqNames;
//    private Integer[] creditReqTotals;
    private String coreCourseIds; // Change to String
    private String courseNames; // Change to String
    private String creditReqNames; // Change to String
    private String creditReqTotals; // Change to String

    public Integer[] getCoreCourseIdsArray() {
        return coreCourseIds != null ?
            Arrays.stream(coreCourseIds.split(",")).map(Integer::parseInt).toArray(Integer[]::new) : new Integer[0];
    }

    public String[] getCourseNamesArray() {
        return courseNames != null ? courseNames.split(",") : new String[0];
    }

    public String[] getCreditReqNamesArray() {
        return creditReqNames != null ? creditReqNames.split(",") : new String[0];
    }

    public Integer[] getCreditReqTotalsArray() {
        return creditReqTotals != null ?
            Arrays.stream(creditReqTotals.split(",")).map(Integer::parseInt).toArray(Integer[]::new) : new Integer[0];
    }
}
