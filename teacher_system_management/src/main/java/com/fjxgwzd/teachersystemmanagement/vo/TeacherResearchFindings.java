package com.fjxgwzd.teachersystemmanagement.vo;

import lombok.Data;

import java.util.List;

@Data
public class TeacherResearchFindings {
    List<TeacherResearchFinding> teacherResearchFindings;
    // 总的页数限制
    private Integer sum;
}
