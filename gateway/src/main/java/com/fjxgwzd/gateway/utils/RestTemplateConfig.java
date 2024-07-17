package com.fjxgwzd.gateway.utils;

import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManagerBuilder;
import org.apache.hc.client5.http.ssl.NoopHostnameVerifier;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactory;
import org.apache.hc.core5.ssl.SSLContextBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

import javax.net.ssl.SSLContext;


public class RestTemplateConfig {

//    @Bean
//    public RestTemplate restTemplate() throws Exception {
//        SSLContext sslContext = SSLContextBuilder.create()
//                .loadTrustMaterial((chain, authType) -> true)
//                .build();
//
//        SSLConnectionSocketFactory socketFactory = new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE);
//        CloseableHttpClient httpClient = HttpClients.custom()
//                .setConnectionManager(PoolingHttpClientConnectionManagerBuilder.create()
//                        .setSSLSocketFactory(sslContext)
//                        .setSSLHostnameVerifier(NoopHostnameVerifier.INSTANCE)
//                        .build())
//                .build();
//
//        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(httpClient);
//        return new RestTemplate(factory);
//    }
}