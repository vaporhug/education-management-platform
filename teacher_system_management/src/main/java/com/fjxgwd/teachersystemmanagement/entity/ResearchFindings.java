package com.fjxgwd.teachersystemmanagement.entity;

import lombok.Data;

@Data
public class ResearchFindings {
    private Integer id;
    private String teacher_id;
    private Short index;
    private Short type;
    private String content;
}
