package com.fjxgwzd.undergraduateacademicadministration.entity;

import java.io.Serializable;

/**
 * (Proctor)实体类
 *
 * @author makejava
 * @since 2024-07-16 03:48:18
 */
public class Proctor implements Serializable {
    private static final long serialVersionUID = 806382471944082764L;
    
    private Integer id;
    
    private String teacherId;
    
    private Integer examSchedId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public Integer getExamSchedId() {
        return examSchedId;
    }

    public void setExamSchedId(Integer examSchedId) {
        this.examSchedId = examSchedId;
    }

}

