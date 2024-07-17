package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.util.Date;

@Data
@Document(indexName = "classroom_reservation")
public class ClassroomReservation {
    @Id
    private Integer id;

    @Field(name = "teacher_id", type = FieldType.Integer)
    private Integer teacherId;

    @Field(name = "reason", type = FieldType.Integer)
    private Integer reason;

    @Field(name = "week", type = FieldType.Integer)
    private Integer week;

    @Field(name = "year", type = FieldType.Integer)
    private Integer year;

    @Field(name = "term_part", type = FieldType.Integer)
    private Integer termPart;

    @Field(name = "day_of_week", type = FieldType.Integer)
    private Integer dayOfWeek;

    @Field(name = "class_period_from", type = FieldType.Integer)
    private Integer classPeriodFrom;

    @Field(name = "class_period_to", type = FieldType.Integer)
    private Integer classPeriodTo;

    @Field(name = "processor_id", type = FieldType.Integer)
    private Integer processorId;

    @Field(name = "processed_at", type = FieldType.Date)
    private Date processedAt;

    @Field(name = "result", type = FieldType.Integer)
    private Integer result;

    @Field(name = "classroom_id", type = FieldType.Integer)
    private Integer classroomId;

    @Field(name = "act_name", type = FieldType.Text)
    private String actName;

    @Field(name = "canceled", type = FieldType.Integer)
    private Integer canceled;

    @Field(name = "reason_detail", type = FieldType.Text)
    private String reasonDetail;
}
