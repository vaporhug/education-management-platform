package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Data
@Document(indexName = "course_selection")
public class CourseSelection {
    @Id
    private Integer id;
    @Field(name = "course_sec_id",type = FieldType.Integer)
    private Integer courseSecId;
    @Field(name = "stu_id",type = FieldType.Text)
    private String studentId;
    @Field(name = "score",type = FieldType.Integer)
    private Integer score;
    @Field(name = "status",type = FieldType.Integer)
    private Integer status;
}
