package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;


@Data
@Document(indexName = "school")
public class School {
    @Id
    private Integer id;
    @Field(type = FieldType.Text)
    private String name;
}
