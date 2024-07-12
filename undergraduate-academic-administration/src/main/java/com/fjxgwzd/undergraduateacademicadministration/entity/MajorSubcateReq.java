package com.fjxgwzd.undergraduateacademicadministration.entity;

import lombok.Data;

@Data
public class MajorSubcateReq {
    private Integer id;
    private Short majorId;
    private Short cohortYear;
    private Short subcate;
    private String require;
}
