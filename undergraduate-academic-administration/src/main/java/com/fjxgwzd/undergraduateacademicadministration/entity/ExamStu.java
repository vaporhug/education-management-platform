package com.fjxgwzd.undergraduateacademicadministration.entity;

import java.io.Serializable;

/**
 * (ExamStu)实体类
 *
 * @author makejava
 * @since 2024-07-16 06:17:15
 */
public class ExamStu implements Serializable {
    private static final long serialVersionUID = -55992795568804294L;
    
    private Integer id;
    
    private Integer examSchedId;
    
    private String stuId;
    /**
     * 正常考试，缺考状态的枚举
     */
    private Integer status;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getExamSchedId() {
        return examSchedId;
    }

    public void setExamSchedId(Integer examSchedId) {
        this.examSchedId = examSchedId;
    }

    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

}

