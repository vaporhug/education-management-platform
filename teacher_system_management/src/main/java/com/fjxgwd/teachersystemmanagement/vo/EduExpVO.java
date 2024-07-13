package com.fjxgwd.teachersystemmanagement.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class EduExpVO {
    protected LocalDateTime fromDate;
    protected LocalDateTime toDate;
    protected String uniName;
    protected String majorName;
    protected String bachelor;
}
