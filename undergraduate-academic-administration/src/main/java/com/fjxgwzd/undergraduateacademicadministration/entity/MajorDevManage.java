package com.fjxgwzd.undergraduateacademicadministration.entity;

import lombok.Data;

@Data
public class MajorDevManage {
    private Integer id;
    private Short majorId;
    private Short cohortYear;
    private String intro;
    private String target;
    private Short standardDurationYear;
    private Short minDuration;
    private Short maxDuration;
    private Short degreeAwarded;
    private String req;
    private Short aaoOfficeId;
}
