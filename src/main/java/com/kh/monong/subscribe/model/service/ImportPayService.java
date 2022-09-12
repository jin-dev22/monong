package com.kh.monong.subscribe.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ImportPayService {

	public String getToken() {
		RestTemplate restTemplate = new RestTemplate();
		
		// 서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		Map<String, Object> map = new HashMap<>();
		map.put("imp_key", "1480425783421144");
		map.put("imp_secret", "s40CDRqPexBS6w9QbZd62CTK6yILrMWq5ro7WNiNq606CWMvwPev6W9Xe2YnzWre9FQtVMZQrh0LBEep");
		
		Gson gson = new Gson();
		String json = gson.toJson(map);
		
		// 서버로 요청할 Body
		HttpEntity<String> entity = new HttpEntity<>(json,headers);
		return restTemplate.postForObject("https://api.iamport.kr/users/getToken", entity, String.class);
	}
}
