package com.fjxgwzd.teacherresourcesharing.vo;

import com.fjxgwzd.teacherresourcesharing.entity.File;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class ChapterVO {
    private Integer chapter2Id;
    private String chapter2Name;
    private MaterialVO material;
}
