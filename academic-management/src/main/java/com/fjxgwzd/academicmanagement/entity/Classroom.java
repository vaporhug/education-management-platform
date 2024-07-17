package com.fjxgwzd.academicmanagement.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Document(indexName = "classroom")
@Data
public class Classroom {
    @Id
    private Integer id;
    @Field(name = "building_name",type = FieldType.Text)
    private String buildingName;
    @Field(name = "room_number" ,type = FieldType.Text)
    private String roomNumber;
    @Field(name = "campus_id", type = FieldType.Integer)//
    private Integer campusId;
    @Field( type = FieldType.Integer)
    private Integer type;
    @Field(name = "seat_num" ,type = FieldType.Integer)
    private Integer seatNum;
    @Field(type = FieldType.Integer)
    private Integer area;
}
