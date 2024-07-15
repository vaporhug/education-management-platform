package com.fjxgwzd.teachersystemmanagement.vo;

import lombok.Data;

import java.util.List;

@Data
public class TotalTeacherDetailVO {
    private Integer sum;
    private List<TeacherDetailInfoVO> teacherDetailVOList;
}
