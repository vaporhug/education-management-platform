package com.fjxgwzd.undergraduateacademicadministration.entity;

import java.util.Date;
import java.io.Serializable;

/**
 * (Counselor)实体类
 *
 * @author makejava
 * @since 2024-07-14 13:49:14
 */
public class Counselor implements Serializable {
    private static final long serialVersionUID = -32908740604821211L;
    
    private String id;
    
    private String name;
    
    private Date bir;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBir() {
        return bir;
    }

    public void setBir(Date bir) {
        this.bir = bir;
    }

}

