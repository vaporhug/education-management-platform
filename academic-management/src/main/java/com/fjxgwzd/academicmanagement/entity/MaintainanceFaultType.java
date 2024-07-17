package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Data
@Document(indexName = "maintainance_fault_type")
public class MaintainanceFaultType {
    @Id
    private Integer id;
    @Field(name = "maint_id", type = FieldType.Integer)
    private Integer maintId;
    @Field(name = "type", type = FieldType.Integer)
    private Integer type;
    @Field(name = "extra_desc", type = FieldType.Text)
    private String extraDesc;
}
