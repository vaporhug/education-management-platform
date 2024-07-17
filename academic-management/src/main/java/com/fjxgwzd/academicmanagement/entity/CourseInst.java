package com.fjxgwzd.academicmanagement.entity;


import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;
@Data
@Document(indexName = "course_inst")
public class CourseInst {
    @Id
    private Integer id;

    @Field(name = "course_id", type = FieldType.Text)
    private String courseId;

    @Field(name = "year", type = FieldType.Integer)
    private Integer year;

    @Field(name = "term_part", type = FieldType.Integer)
    private Integer termPart;

    @Field(name = "instructor_msg", type = FieldType.Text)
    private String instructorMsg;

    @Field(name = "overview", type = FieldType.Text)
    private String overview;

    @Field(name = "target", type = FieldType.Text)
    private String target;

    @Field(name = "assess_method", type = FieldType.Integer)
    private Integer assessMethod;

    @Field(name = "method_detal", type = FieldType.Text)
    private String methodDetail;

    @Field(name = "total_class_hour", type = FieldType.Integer)
    private Integer totalClassHour;

    @Field(name = "max_num", type = FieldType.Integer)
    private Integer maxNum;
}
