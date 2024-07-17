package com.fjxgwzd.academicmanagement.entity;


import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.util.Date;

@Data
@Document(indexName = "teacher")
public class Teacher {
    @Id
    private String id;
    @Field(name = "name",type = FieldType.Text)
    private String name;
    @Field(name = "hire_date",type = FieldType.Date)
    private Date hireDate;
    @Field(type = FieldType.Text)
    private String phone;
    @Field(type = FieldType.Integer)
    private Integer type;
    @Field(type = FieldType.Integer)
    private Integer gender;
    @Field(type = FieldType.Text)
    private String email;
    @Field(name = "major_id",type = FieldType.Text)
    private String majorId;
    @Field(name = "school_id",type = FieldType.Text)
    private String schoolId;
    @Field(type = FieldType.Text)
    private String title;
    @Field(type = FieldType.Text)
    private String bachelor;
    @Field(type = FieldType.Text)
    private String desc;
    @Field(name = "research_focus",type = FieldType.Text)
    private String researchFocus;
    @Field(type = FieldType.Text)
    private String identity;
    @Field(type = FieldType.Text)
    private String address;
    @Field(name = "teacher_pic",type = FieldType.Integer)
    private Integer teacherPic;
}
