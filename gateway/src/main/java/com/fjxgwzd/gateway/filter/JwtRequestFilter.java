package com.fjxgwzd.gateway.filter;

import com.fjxgwzd.gateway.service.CasService;
import com.fjxgwzd.gateway.service.JwtService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpRequestDecorator;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;
import java.util.ArrayList;
import java.util.List;

@Component
@Order(1)
public class JwtRequestFilter  implements WebFilter {

    @Autowired
    private JwtService jwtService;

    @Autowired
    private CasService casService;

    private static final List<String> EXCLUDED_PATHS = new ArrayList<>();

    static {
        EXCLUDED_PATHS.add("/auth/login");
        EXCLUDED_PATHS.add("/register");
        EXCLUDED_PATHS.add("/public");
        EXCLUDED_PATHS.add("/static");
        EXCLUDED_PATHS.add("/ts/TeacherInfo/teacherInfo");
        EXCLUDED_PATHS.add("/ts/TeacherInfo/teacherDetails");
        EXCLUDED_PATHS.add("/ts/TeacherInfo/teacherHomeDetails");
        EXCLUDED_PATHS.add("/tr/files/school_major");
        // 添加更多需要排除的路径
    }

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
        ServerHttpRequest request = exchange.getRequest();
        String path = request.getURI().getPath();
        // 检查请求路径是否在排除列表中
        if (EXCLUDED_PATHS.stream().anyMatch(path::startsWith)) {
            return chain.filter(exchange);
        }

        final String authorizationHeader = exchange.getRequest().getHeaders().getFirst("Authorization");

        String jwt = null;
        String tgt = null;
        String st = null;
//        String primaryInfo = null;
        final String[] primaryInfo = new String[1];

        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            jwt = authorizationHeader.substring(7);
            tgt = jwtService.extractSubject(jwt);
            String requestURL = exchange.getRequest().getURI().toString();
            st = casService.getSt(tgt, requestURL);
//            primaryInfo = casService.getPrimaryInfoBySt(tgt, st);
            primaryInfo[0] = casService.getPrimaryInfoBySt(requestURL, st);
        }

        if (jwt == null || tgt == null || st == null || primaryInfo[0] == null) {
            exchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
            return exchange.getResponse().writeWith(Mono.just(exchange.getResponse()
                    .bufferFactory()
                    .wrap("Authentication failed, please login again.".getBytes())));
        }

        // 创建一个新的ServerHttpRequestDecorator
        ServerHttpRequestDecorator decoratedRequest = new ServerHttpRequestDecorator(exchange.getRequest()) {
            @Override
            public HttpHeaders getHeaders() {
                HttpHeaders headers = new HttpHeaders();
                headers.putAll(super.getHeaders());
                headers.add("PrimaryInfo", primaryInfo[0]);
                return headers;
            }
        };

        // 使用新的请求装饰器创建新的ServerWebExchange
        ServerWebExchange decoratedExchange = exchange.mutate().request(decoratedRequest).build();

        return chain.filter(decoratedExchange);

    }
}