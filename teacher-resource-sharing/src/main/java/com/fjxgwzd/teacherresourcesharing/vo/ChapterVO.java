package com.fjxgwzd.teacherresourcesharing.vo;

import com.fjxgwzd.teacherresourcesharing.entity.File;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class ChapterVO {
    private Integer chapterId;
    private String chapterName;
    private List<MaterialVO> materials;
}
