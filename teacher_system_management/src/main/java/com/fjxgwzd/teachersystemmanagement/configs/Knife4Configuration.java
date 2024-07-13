package com.fjxgwzd.teachersystemmanagement.configs;


import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springdoc.core.models.GroupedOpenApi;

@Configuration
// 添加API文档配置
public class Knife4Configuration {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("老师端服务管理系统")
                        .version("1.0")
                        .description("老师端服务管理系统的接口文档"));
    }

    @Bean
    public GroupedOpenApi teacherResourceSharingApi() {
        return GroupedOpenApi.builder().group("老师信息获取").pathsToMatch("/TeacherInfo/**").build();
    }
}
