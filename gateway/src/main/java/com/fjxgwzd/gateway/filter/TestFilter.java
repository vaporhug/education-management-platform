package com.fjxgwzd.gateway.filter;


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;


import java.io.IOException;

@Component
public class TestFilter implements org.springframework.web.server.WebFilter {

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
        // 在这里添加你的过滤逻辑
        // ...
        System.out.println("TestFilter");

        // 然后调用chain.filter()继续处理请求
        return chain.filter(exchange);
    }
}
