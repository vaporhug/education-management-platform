package com.fjxgwzd.undergraduateacademicadministration.vo;

import io.swagger.v3.oas.models.security.SecurityScheme;
import lombok.Data;

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
    private Integer[] coreCourseIds;
    private String[] courseNames;
    private String[] creditReqNames;
    private Integer[] creditReqTotals;
}
