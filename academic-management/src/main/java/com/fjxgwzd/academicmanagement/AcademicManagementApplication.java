package com.fjxgwzd.academicmanagement;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
public class AcademicManagementApplication {
    public static void main(String[] args) {
        SpringApplication.run(AcademicManagementApplication.class, args);
    }

}
