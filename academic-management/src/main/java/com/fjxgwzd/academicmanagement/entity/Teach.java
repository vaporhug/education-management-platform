package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Data
@Document(indexName = "teach")
public class Teach {
    @Id
    private Integer id;
    @Field(name = "course_id",type = FieldType.Text)
    private String courseId;
    @Field(name = "teacherId",type = FieldType.Text)
    private String teacherId;
}
