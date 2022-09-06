package com.kh.monong.subscribe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.Vegetables;
import com.kh.monong.subscribe.model.service.SubscribeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/subscribe")
public class SubscribeController {

	@Autowired
	SubscribeService subscribeService;

	// 선아코드 시작
	@GetMapping("/subscribeOrder.do")
	public void order() {
	}
	// 선아코드 끝

	// 미송코드 시작
	@GetMapping("/subscribePlan.do")
	public void subscriptionPlan(Model model) {
		List<SubscriptionProduct> subscriptionProduct = subscribeService.getSubscriptionProduct();
		log.debug("subscriptionProduct = {}", subscriptionProduct);

		List<Vegetables> vegetables = subscribeService.getVegetables();
		log.debug("vegetables = {}", vegetables);

		model.addAttribute("subscriptionProduct", subscriptionProduct);
		model.addAttribute("vegetables", vegetables);
	}
	
	@PostMapping("/subscribePlan.do")
	public String subscribePlan(
			@RequestParam String sProduct, 
			@RequestParam String[] sExcludeVegs,
			@RequestParam int sDeliveryCycle) {

		return "subscribe/subscribeOrder";
	}
	// 미송코드 끝

}
