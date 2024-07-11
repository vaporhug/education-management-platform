package com.fjxgwzd.teacherresourcesharing.vo;

import com.fjxgwzd.teacherresourcesharing.entity.File;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ChapterVO {
    // chapter_id
    private Integer chapter_id;
    // 文件级别名
    private String title;
    // 文件的级别
    private Short titleLevel;
    // 文件的具体信息，如果找不到，则设置该file为null
    private File file;
    // 创建时间
    private LocalDateTime createTime;
    // 上传者
    private String uploader_id;
    // 文件名
    private String name;
}
