package com.fjxgwzd.undergraduateacademicadministration.entity;

import java.io.Serializable;

/**
 * (Campus)实体类
 *
 * @author makejava
 * @since 2024-07-14 13:49:15
 */
public class Campus implements Serializable {
    private static final long serialVersionUID = -91340345650149563L;
    
    private short id;
    
    private String name;
    
    private String location;
    
    private String desc;

    public short getId() {
        return id;
    }

    public void setId(short id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

}

