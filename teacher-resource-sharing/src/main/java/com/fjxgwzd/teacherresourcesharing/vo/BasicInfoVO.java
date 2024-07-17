package com.fjxgwzd.teacherresourcesharing.vo;

import lombok.Data;

import java.util.List;

@Data
public class BasicInfoVO {
    private List<CampusVO> campusVOList;
    private Boolean nowTermPart;
    private Integer earliestTermYear;
    private Boolean earliestTermPart;
    private Integer nowWeek;
    private List<schoolMajorList> schoolMajorList;;
}
