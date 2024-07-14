package com.fjxgwzd.undergraduateacademicadministration.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Semester {
    private Integer id;
    private LocalDateTime from_date;
    private LocalDateTime to_date;
    private Integer year;
    private boolean term_part;
}
