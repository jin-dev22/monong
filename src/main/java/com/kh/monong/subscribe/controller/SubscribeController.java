package com.kh.monong.subscribe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.monong.common.HelloSpringUtils;
import com.kh.monong.member.model.service.MemberService;
import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.Vegetables;
import com.kh.monong.subscribe.model.service.SubscribeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/subscribe")
public class SubscribeController {
	
	@Autowired
	SubscribeService subscribeService;
	
	@Autowired
	MemberService memberService;
	
	// 선아코드 시작	
	@PostMapping("/subscribeOrder.do")
	public String subscribePlan(
			@RequestParam String sProduct, 
			@RequestParam String[] sExcludeVegs,
			@RequestParam int sDeliveryCycle,
			Model model) {
		SubscriptionProduct orderProduct = subscribeService.selectProductInfoByCode(sProduct);
		
		model.addAttribute("orderProduct", orderProduct);
		model.addAttribute("sExcludeVegs", sExcludeVegs);
		model.addAttribute("sDeliveryCycle", sDeliveryCycle);
		return "/subscribe/subscribeOrder";
	}
	
	@PostMapping("/insertCardInfo.do")
	public ResponseEntity<?> insertCardInfo(@RequestParam String customerUid, CardInfo cardInfo, Model model) {
		log.debug("customerUid = {}", customerUid);
		log.debug("cardInfo = {}", cardInfo);
		
		int result = subscribeService.insertCardInfo(cardInfo);
		log.debug("cardInfo.getCustomerUid = {}", cardInfo.getCustomerUid());
		// 방금 등록된 카드정보 가져오기
		CardInfo recentCard = subscribeService.findCardInfoByUid(cardInfo.getCustomerUid());
		return ResponseEntity.status(HttpStatus.OK).body(recentCard);
	}
	
	@PostMapping("/insertSubOrder.do")
	public ResponseEntity<?> insertSubOrder(@RequestParam String sNo, @RequestParam String customerUid, Subscription subscription, Model model) {		
		log.debug("sNo = {}", sNo);
		log.debug("subscription = {}", subscription);
		log.debug("model = {}", model);
		int cardInfoNo = subscribeService.findCardInfoNoByUid(customerUid);
		
		int result = subscribeService.insertSubscription(subscription, cardInfoNo);
		if(result == 1) {
			return ResponseEntity.status(HttpStatus.OK).body(null); // redirect로 바꾸기 addAttribute 해서 complete 페이지로			
		}
		return null;
	}
	
	@GetMapping("/complete.do")
	public void complete() {}

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
	
	@GetMapping("/subscribeMain.do")
	public void subscribeMain(Model model) {
		int sReviewStarAvg = subscribeService.getSubscriptionReviewStarAvg();
		log.debug("sReviewStarAvg = {}", sReviewStarAvg);
		
		int totalContent = subscribeService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		
		model.addAttribute("sReviewStarAvg", sReviewStarAvg);
		model.addAttribute("totalContent", totalContent);
	}

	@GetMapping("/subscribeReviewList.do")
	public ResponseEntity<?> subscribeReviewList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		List<SubscriptionReview> sReviewList = subscribeService.selectSubscriptionReviewList(param);
		log.debug("sReviewList = {}", sReviewList);
		
		int totalContent = subscribeService.getTotalContent();
		
		String url = request.getRequestURI();
		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
		
		Map<String, Object> returnVal = new HashMap<>();
		returnVal.put("sReviewList", sReviewList);
		returnVal.put("pagebar", pagebar);
		
		return ResponseEntity.ok(returnVal);
	}
	
	@GetMapping("/subscribeReviewDetail.do")
	public ResponseEntity<?> subscribeReviewDetail(@RequestParam String sReviewNo) {
		log.debug("sReviewNo = {}", sReviewNo);
		
		SubscriptionReview sReview = subscribeService.selectOneSubscriptionReview(sReviewNo);
		log.debug("sReview = {}", sReview);
		
		return ResponseEntity.ok(sReview);
	}
	
	@PostMapping("/subscribeReviewRecommend.do")
	public ResponseEntity<?> subscribeReviewRecommend(@RequestParam(required = false) String sReviewNo) {
		log.debug("sReviewNo = {}", sReviewNo);
		
		int result = subscribeService.updateSubscribeReviewRecommend(sReviewNo);
		
		return ResponseEntity.ok(result);
	}
	// 미송코드 끝

}
