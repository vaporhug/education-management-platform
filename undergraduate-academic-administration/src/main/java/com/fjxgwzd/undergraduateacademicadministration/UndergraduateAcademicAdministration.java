package com.fjxgwzd.undergraduateacademicadministration;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.fjxgwzd.undergraduateacademicadministration.dao")
@MapperScan("com.fjxgwzd.undergraduateacademicadministration.mapper")
public class UndergraduateAcademicAdministration {
    public static void main(String[] args){
        SpringApplication.run(UndergraduateAcademicAdministration.class, args);
    }
}