package com.kh.monong.subscribe.controller;


import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.common.HelloSpringUtils;
import com.kh.monong.member.model.service.MemberService;
import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.Vegetables;
import com.kh.monong.subscribe.model.service.ImportPayService;
import com.kh.monong.subscribe.model.service.RequestSubPayment;
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
	@Autowired
	ImportPayService importPayService;
	@Autowired
	RequestSubPayment requestSubPayment;
	
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
	public int insertCardInfo(
			@RequestParam String customerUid, CardInfo cardInfo
			) {
		return subscribeService.insertCardInfo(cardInfo);
	}
	
	@PostMapping("/subComplete.do")
	public String insertSubOrder(
			@RequestParam String sNo, @RequestParam String customerUid,
			@RequestParam String sOrderNo,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate sNextDeliveryDate,
			SubscriptionOrder subscriptionOrder, Subscription subscription, RedirectAttributes redirectAttr
		) {
		int cardInfoNo = subscribeService.findCardInfoNoByUid(customerUid);
		
		// 구독정보 insert
		int result = 0;
		if(cardInfoNo != 0) {
			subscription.setCardInfoNo(cardInfoNo);
			result = subscribeService.insertSubscription(subscriptionOrder, subscription);
		}
		SubscriptionOrder orderList = null;
		if(result == 1) {
			orderList = subscribeService.selectSubscriptionOrderRecent(subscriptionOrder.getSNo());
		}
		redirectAttr.addFlashAttribute("orderList", orderList);
		redirectAttr.addFlashAttribute("msg", "구독이 완료되었습니다. :)");
		return "redirect:/subscribe/subComplate.do";
	}
	
	@GetMapping("/subComplate.do")
	public void subComplete(Authentication authentication, Model model) {
		List<SubscriptionProduct> subscriptionProduct = subscribeService.getSubscriptionProduct();
		model.addAttribute("subscriptionProduct", subscriptionProduct);
	}
	
	// 스케줄 미완성
	@Autowired
	ReqPayScheduler scheduler;
	
	@PostMapping("/payschedule.do")
	public void payschedule(String customerUid, int amount){
//		Map<String, Object> map = new HashMap<>();
//		map.put("customer_uid", customerUid);
//		map.put("merchant_uid", merchantUid);
//		map.put("amount", amount);
//		map.put("name", memberName);
		
//		return ResponseEntity.ok(requestSubPayment.requestPayAgain(map));
		
		// 매번 변경되어야 하는 주문번호 - ex) SO + 220901(년월일) + 1201(시분) + 랜덤3자리 = 총 15자리		
		// 1. 다음배송일의 년월일 가져오기
		Subscription subscription = subscribeService.findNextDeliveryDateByUid(customerUid);
		LocalDate nextDeliveryDate = subscription.getSNextDeliveryDate();
		
		// 2. 기존에는 시분 + 랜덤3자리였으나 예약결제는 시분은 없기때문에 랜덤 7자리로 변경
		Random random = new Random();
		StringBuilder sb = new StringBuilder();
		
		final int len = 7;
		for(int i = 0; i < len; i++) {
			sb.append(random.nextInt(10));
		}
		String ran = sb.toString();
		log.debug("ran = {}", ran);
		
		String merchantUid = "SO" + nextDeliveryDate + ran;
		log.debug("새로생성 merchantUid = {}", merchantUid);
		
		scheduler.startScheduler(customerUid, amount, merchantUid);
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
	
	@GetMapping("/subscribeMain.do")
	public void subscribeMain(Model model) {
		int sReviewStarAvg = subscribeService.getSubscriptionReviewStarAvg();
		log.debug("sReviewStarAvg = {}", sReviewStarAvg);
		
		int totalContent = subscribeService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		
		// 상품정보 불러오기
		List<SubscriptionProduct> subscriptionProduct = subscribeService.getSubscriptionProduct();
		
		model.addAttribute("subscriptionProduct", subscriptionProduct);
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
