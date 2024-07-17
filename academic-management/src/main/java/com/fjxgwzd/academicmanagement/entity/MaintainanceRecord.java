package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.util.Date;

@Data
@Document(indexName = "maintainance_record")
public class MaintainanceRecord {
    @Id
    private Integer id;
    @Field(name = "report_id",type= FieldType.Integer)
    private Integer reportId;
    @Field(name = "maint_from",type = FieldType.Date)
    private Date maintFrom;
    @Field(name = "maint_to",type = FieldType.Date)
    private Date maintTo;
    @Field(name = "maint_detail",type = FieldType.Text)
    private String maintDetail;
}
