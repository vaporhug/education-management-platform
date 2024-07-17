package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;
@Data
@Document(indexName = "course_inst_section")
public class CourseInstSection {
    @Id
    private Integer id;

    @Field(name = "course_inst_id", type = FieldType.Integer)
    private Integer courseInstId;

    @Field(name = "name", type = FieldType.Text)
    private String name;
}
