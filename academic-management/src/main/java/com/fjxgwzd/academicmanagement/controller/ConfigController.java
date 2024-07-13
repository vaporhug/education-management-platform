package com.fjxgwzd.academicmanagement.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RefreshScope
public class ConfigController {

    @Value("${useLocalCache:false}")
    private boolean useLocalCache;

    @Value("${project.name:dfafafda}")
    private String projectName;

    @RequestMapping("/get")
    public String get1() {
        return projectName ;
    }

    @RequestMapping("/ac/get")
    public boolean get(@RequestHeader("PrimaryInfo") String primaryInfo) {
        System.out.println(primaryInfo);
        return useLocalCache;
    }

}
