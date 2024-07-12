package com.fjxgwzd.undergraduateacademicadministration.entity;

import lombok.Data;

@Data
public class CoreCourseForMajor {
    private Integer id;
    private Short majorId;
    private Short cohortYear;
    private Integer courseStructId;
}
