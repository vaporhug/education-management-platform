package com.fjxgwzd.gateway.service;

import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;
import java.security.cert.X509Certificate;
import java.util.Objects;


@Service
public class CasService {

    @Value("${cas-rest.url.request-tgt}")
    private String requestTgtUrl;
    @Value("${cas-rest.url.request-st}")
    private String requestST;
    public String getTgt(String username, String password) {
        try{
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
            map.add("username", username);
            map.add("password", password);

            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);
            ResponseEntity<String> response = restTemplate.postForEntity(requestTgtUrl, request, String.class);
            String rawResStr = Objects.requireNonNull(response.getHeaders().getLocation()).toString();
            int valid_index = rawResStr.lastIndexOf("TGT");
            return rawResStr.substring(valid_index);
        }catch (Exception e){
            e.printStackTrace();
            return "False";
        }
    }

    public String getSt(String tgt, String serviceUrl) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("service", serviceUrl);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);
        ResponseEntity<String> response = restTemplate.postForEntity(requestTgtUrl+"/"+tgt, request, String.class);
        return response.getBody();
        /**
         * <200 OK OK,ST-2-ovFArCeSNbxfrZ6-32o31ouxSyw-ShuodeMacBook-Air,[requestId:"46cf5c3b-313e-4529-8d1f-aeee215c7b8e", Vary:"Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers", Cache-Control:"no-cache, no-store, max-age=0, must-revalidate", Pragma:"no-cache", Expires:"0", Strict-Transport-Security:"max-age=15768000 ; includeSubDomains", X-Content-Type-Options:"nosniff", X-Frame-Options:"DENY", X-XSS-Protection:"1; mode=block", Content-Security-Policy:"script-src 'self' 'unsafe-inline' 'unsafe-eval'; object-src 'none';", Content-Type:"text/plain;charset=UTF-8", Content-Length:"50", Date:"Fri, 12 Jul 2024 07:05:38 GMT", Keep-Alive:"timeout=20", Connection:"keep-alive", Server:"Apereo CAS"]>
         */
    }

    //这里是从返回的一大堆信息里提取吃username，之后打算换成id，这种做法的鲁棒性很低
    public String getPrimaryInfoBySt(String serviceUrl, String st) {
        RestTemplate restTemplate = new RestTemplate();
        String validateUrl = String.format(requestST+"?service=%s&ticket=%s", serviceUrl, st);
        ResponseEntity<String> response = restTemplate.getForEntity(validateUrl, String.class);
        // 解析响应以提取用户信息（XML或JSON）
        String rawResStr = response.getBody();
        String resStr = "";
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new InputSource(new StringReader(rawResStr)));
            NodeList nodeList = doc.getElementsByTagName("cas:user");
            resStr = nodeList.item(0).getTextContent();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return resStr;
    }
}
