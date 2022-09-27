package com.kh.monong.subscribe.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.kh.monong.subscribe.model.dto.GetTokenDto;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class RequestSubPayment {
	
	@Setter(onMethod_ = @Autowired)
	private ImportPayService pay;
	
	public String requestPayAgain(Map<String, Object> map) {
		String token = pay.getToken();
		Gson str = new Gson();
		token = token.substring(token.indexOf("response") + 10);
		token = token.substring(0, token.length() - 1);
		
		GetTokenDto vo = str.fromJson(token, GetTokenDto.class);
		
		String access_token = vo.getAccess_token();
		log.debug("access_token = {}", access_token);
		
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setBearerAuth(access_token);
		
		Gson var = new Gson();
		String json = var.toJson(map);
		// log.debug("json = {}", json);
		HttpEntity<String> entity = new HttpEntity<>(json, headers);
		
		return restTemplate.postForObject(
				"https://api.iamport.kr/subscribe/payments/again", entity, String.class); 
	}
}
