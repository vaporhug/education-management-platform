package com.fjxgwzd.gateway.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {
    @Value("${testproperty:ru}")
    private String useLocalCache;


    @RequestMapping("/get")
    public String get() {
        return useLocalCache;
    }

    @RequestMapping("/public/test")
    public String test() {
        return "test";
    }
    @GetMapping("/getPrimaryInfo")
    public String getPrimaryInfo(@RequestHeader("PrimaryInfo") String primaryInfo) {
        // Get the primaryInfo from the request attributes
        // Return the primaryInfo
        return primaryInfo;
    }



}
