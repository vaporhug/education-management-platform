package com.fjxgwzd.teacherresourcesharing;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.fjxgwzd.teacherresourcesharing.mapper")
public class TeacherResourceSharingApplication {

	public static void main(String[] args) {
		SpringApplication.run(TeacherResourceSharingApplication.class, args);
	}

}
