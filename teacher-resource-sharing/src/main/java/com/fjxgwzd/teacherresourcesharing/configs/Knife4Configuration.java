package com.fjxgwzd.teacherresourcesharing.configs;


import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
// 添加API文档配置
public class Knife4Configuration {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("教学管理系统项目API")
                        .version("1.0")
                        .description("教学管理系统的接口文档"));
    }

    @Bean
    public GroupedOpenApi teacherResourceSharingApi() {
        return GroupedOpenApi.builder().group("教师资源共享").pathsToMatch("/files/**").build();
    }

    @Bean
    public GroupedOpenApi courseResourceSharingApi() {
        return GroupedOpenApi.builder().group("课程资源共享").pathsToMatch("/courses/**").build();
    }
}
