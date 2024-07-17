package com.fjxgwzd.teacherresourcesharing.vo;

import lombok.Data;

@Data
public class CampusVO {
    private Integer campusId;
    private String campusName;
    private String[] buildings;

    public void setBuildings(String buildings) {
        if (buildings != null && !buildings.isEmpty()) {
            this.buildings = buildings.split(",");
        }else {
            this.buildings = new String[0];
        }
    }
}
