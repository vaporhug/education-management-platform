package com.fjxgwzd.teachersystemmanagement.entity;

import lombok.Data;

@Data
public class Classroom {
    private Integer id;
    private String buildingName;
    private String roomNumber;
    private Short campusId;
    private Short type;
    private Short seatNum;
    private Short area;
}
