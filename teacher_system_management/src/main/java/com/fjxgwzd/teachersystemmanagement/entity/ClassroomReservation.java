package com.fjxgwzd.teachersystemmanagement.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ClassroomReservation {
    private Integer id;
    private Integer teacherId;
    private Short reason;
    private Short week;
    private Integer year;
    private boolean termPart;
    private Short dayOfWeek;
    private Short classPeriodFrom;
    private Short classPeriodTo;
    private Integer processorId;
    private LocalDateTime processAt;
    private Short result;
    private Integer classroomId;
    private String actName;
    private boolean canceled;
    private String reasonDetail;
}
