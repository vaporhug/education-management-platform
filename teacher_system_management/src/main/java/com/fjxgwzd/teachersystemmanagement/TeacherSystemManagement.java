package com.fjxgwzd.teachersystemmanagement;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.fjxgwzd.teachersystemmanagement.mapper")
public class TeacherSystemManagement {
    public static void main(String[] args) {
		SpringApplication.run(TeacherSystemManagement.class, args);
	}
}
