package com.fjxgwzd.teachersystemmanagement.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class FaultReport {
    private Integer id;
    private Integer classroomId;
    private Short reporterRole;
    private String identity;
    private String faultDesc;
    private LocalDateTime reportTime;
    private Short status;
}
