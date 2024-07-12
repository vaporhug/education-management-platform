package com.fjxgwzd.undergraduateacademicadministration.configs;

import io.swagger.v3.oas.models.info.Info;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.swagger.v3.oas.models.OpenAPI;

@Configuration
// 添加API文档配置
public class Knife4Configuration {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("本科生教务管理系统")
                        .version("1.0")
                        .description("本科生教务管理系统的接口文档"));
    }

    @Bean
    public GroupedOpenApi teacherResourceSharingApi() {
        return GroupedOpenApi.builder().group("教务管理").pathsToMatch("/admin/**").build();
    }
}
