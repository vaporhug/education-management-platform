package com.fjxgwzd.undergraduateacademicadministration.entity;

import java.io.Serializable;

/**
 * (Class)实体类
 *
 * @author makejava
 * @since 2024-07-14 13:49:14
 */
public class Class implements Serializable {
    private static final long serialVersionUID = -52895283438140490L;
    
    private Integer id;
    
    private String name;
    
    private short majorId;
    
    private short feStuNum;
    
    private short maleStuNum;
    
    private String counselorId;
    
    private short campusId;
    
    private short startYear;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public short getMajorId() {
        return majorId;
    }

    public void setMajorId(short majorId) {
        this.majorId = majorId;
    }

    public short getFeStuNum() {
        return feStuNum;
    }

    public void setFeStuNum(short feStuNum) {
        this.feStuNum = feStuNum;
    }

    public short getMaleStuNum() {
        return maleStuNum;
    }

    public void setMaleStuNum(short maleStuNum) {
        this.maleStuNum = maleStuNum;
    }

    public String getCounselorId() {
        return counselorId;
    }

    public void setCounselorId(String counselorId) {
        this.counselorId = counselorId;
    }

    public short getCampusId() {
        return campusId;
    }

    public void setCampusId(short campusId) {
        this.campusId = campusId;
    }

    public short getStartYear() {
        return startYear;
    }

    public void setStartYear(short startYear) {
        this.startYear = startYear;
    }
}

