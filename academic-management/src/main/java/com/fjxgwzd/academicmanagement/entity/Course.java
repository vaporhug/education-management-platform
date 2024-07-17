package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Data
@Document(indexName = "course")
public class Course {
    @Id
    private String id;

    @Field(name = "name", type = FieldType.Text)
    private String name;

    @Field(name = "course_type", type = FieldType.Integer)
    private Integer courseType;

    @Field(name = "course_cate", type = FieldType.Integer)
    private Integer courseCate;

    @Field(name = "course_for", type = FieldType.Integer)
    private Integer courseFor;

    @Field(name = "credit", type = FieldType.Integer)
    private Integer credit;

    @Field(name = "grade_level", type = FieldType.Integer)
    private Integer gradeLevel;

    @Field(name = "school_id", type = FieldType.Integer)
    private Integer schoolId;

    @Field(name = "course_pic", type = FieldType.Long)
    private Long coursePic;
}
