package com.fjxgwzd.undergraduateacademicadministration.entity;

import lombok.Data;

@Data
public class MajorCreditReq {
    private Integer id;
    private Short majorId;
    private Short creditType;
    private Short creditTotal;
}
