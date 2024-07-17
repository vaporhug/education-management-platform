package com.fjxgwzd.academicmanagement.entity;


import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Data
@Document(indexName = "classroom_status")
public class ClassroomStatus {
    @Id
    private Integer id;
    @Field(name = "classroom_id",type = FieldType.Integer)
    private Integer classroomId;
    @Field(name = "status",type = FieldType.Integer)
    private Integer status;
    @Field(name = "year",type = FieldType.Integer)
    private Integer year;
    @Field(name = "week",type = FieldType.Integer)
    private Integer week;
    @Field(name = "day_of_week",type = FieldType.Integer)
    private Integer dayOfWeek;
    @Field(name = "period_from",type = FieldType.Integer)
    private Integer periodFrom;
    @Field(name = "period_to",type = FieldType.Integer)
    private Integer periodTo;
    @Field(name = "term_part",type = FieldType.Integer)
    private Integer termPart;
}
