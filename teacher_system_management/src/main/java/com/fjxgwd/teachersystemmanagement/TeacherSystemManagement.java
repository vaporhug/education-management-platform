package com.fjxgwd.teachersystemmanagement;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.fjxgwd.teachersystemmanagement.mapper")
public class TeacherSystemManagement {
    public static void main(String[] args) {
		SpringApplication.run(TeacherSystemManagement.class, args);
	}
}
