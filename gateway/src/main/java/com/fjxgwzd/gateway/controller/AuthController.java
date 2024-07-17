package com.fjxgwzd.gateway.controller;

import com.fjxgwzd.common.result.Result;
import com.fjxgwzd.gateway.service.CasService;
import com.fjxgwzd.gateway.service.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private CasService casService;

    @Autowired
    private JwtService jwtService;

    @PostMapping("/login")
    public Result<?> login(@RequestParam String username, @RequestParam String password) {
        // 获取TGT
        String tgt = casService.getTgt(username, password);
        if (tgt.equals("False")) {
            return Result.fail();
        }
        // 生成JWT
        String jwt = jwtService.generateToken(tgt,null);
        System.out.println(jwt.contains("\n"));
        System.out.println(jwt.contains("\r\n"));

        Integer identity = username.length() == 10 ? 1 : username.startsWith("X") ? 2 : 3;
        Map<String,Object> data = new HashMap<>();
        data.put("token",jwt);
        data.put("identity",identity);
        return Result.ok(data);
    }

}
