package com.fjxgwzd.gateway;

import com.fjxgwzd.gateway.service.CasService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class GatewayApplicationTests {

    @Autowired
    private CasService casService;

    @Test
    void contextLoads() {
        String tgt = casService.getTgt("lishuo", "lishuo");
        System.out.println(tgt);
        String st = casService.getSt(tgt, "http://localhost:8081/get");
        System.out.println(st);
        String validateSt = casService.getPrimaryInfoBySt("http://localhost:8081/get", st);
        System.out.println(validateSt);
    }
}
