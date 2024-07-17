package com.fjxgwzd.undergraduateacademicadministration.entity;

import java.io.Serializable;

/**
 * (StuCourseSched)实体类
 *
 * @author makejava
 * @since 2024-07-16 11:21:42
 */
public class StuCourseSched implements Serializable {
    private static final long serialVersionUID = -42121216725721156L;
    
    private Integer id;
    /**
     * 例如，大一上为1，大一下为2
     */
    private Integer semester;
    
    private String stuId;
    
    private Integer courseSchedId;
    /**
     * 准时，迟到，缺课
     */
    private Integer stuAttend;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSemester() {
        return semester;
    }

    public void setSemester(Integer semester) {
        this.semester = semester;
    }

    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
    }

    public Integer getCourseSchedId() {
        return courseSchedId;
    }

    public void setCourseSchedId(Integer courseSchedId) {
        this.courseSchedId = courseSchedId;
    }

    public Integer getStuAttend() {
        return stuAttend;
    }

    public void setStuAttend(Integer stuAttend) {
        this.stuAttend = stuAttend;
    }

}

