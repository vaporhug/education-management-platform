package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.util.Date;

@Data
@Document(indexName = "fault_report")
public class FaultReport {
    @Id
    private Integer id;
    @Field(name = "classroom_id",type = FieldType.Text)
    private Integer classroomId;
    @Field(name = "reporter_role",type = FieldType.Integer)
    private Integer reporterRole;
    @Field(name = "identity",type = FieldType.Text)
    private String identity;
    @Field(name = "fault_desc",type = FieldType.Text)
    private String faultDesc;
    @Field(name = "report_time",type = FieldType.Date)
    private Date reportTime;
    @Field(name = "status",type = FieldType.Integer)
    private Integer status;
}
