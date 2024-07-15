package com.fjxgwzd.undergraduateacademicadministration.vo;

import lombok.Data;

import java.util.List;

@Data
public class TotalStudentDetailVO {
    private Integer sum;
    private List<StudentDetailInfoVO> studentDetailInfoVOList;
}
