

package com.fjxgwzd.undergraduateacademicadministration.vo;

import java.util.List;

public class TotalClassDetailVo {

    Integer sum;
    List<ClassDetailVo> classes;

    public List<ClassDetailVo> getClasses() {
        return classes;
    }

    public void setClasses(List<ClassDetailVo> classes) {
        this.classes = classes;
    }

    public Integer getSum() {
        return sum;
    }

    public void setSum(Integer sum) {
        this.sum = sum;
    }

}
