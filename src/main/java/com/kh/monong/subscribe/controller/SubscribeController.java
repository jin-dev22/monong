package com.kh.monong.subscribe.controller;


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

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.kh.monong.common.HelloSpringUtils;
import com.kh.monong.member.model.dto.Member;
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
	public ResponseEntity<?> insertCardInfo(
			@RequestParam String customerUid, CardInfo cardInfo
			) {
		return ResponseEntity.ok(subscribeService.insertCardInfo(cardInfo));
	}
	
	@PostMapping("/subComplete.do")
	public String insertSubOrder(
			@RequestParam String sNo, @RequestParam String customerUid,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate sNextDeliveryDate,
			Subscription subscription, RedirectAttributes redirectAttr
		) {
		// 카드번호 조회
		int cardInfoNo = subscribeService.findCardInfoNoByUid(customerUid);
		
		// 구독정보 insert
		int result = 0;
		if(cardInfoNo != 0) {
			subscription.setCardInfoNo(cardInfoNo);
			result = subscribeService.insertSubscription(subscription);
		}
		
		Subscription subscriptionList = null;
		if(result == 1) {
			subscriptionList = subscribeService.selectSubscription(subscription.getSNo());
		}
		redirectAttr.addFlashAttribute("subscriptionList", subscriptionList);
		return "redirect:/subscribe/subComplate.do";
	}
	
	@GetMapping("/subComplate.do")
	public void subComplete(Authentication authentication, Model model) {
		List<SubscriptionProduct> subscriptionProduct = subscribeService.getSubscriptionProduct();
		model.addAttribute("subscriptionProduct", subscriptionProduct);
	}
	
	// 스케줄
	@Autowired
	ReqPayScheduler scheduler;
	@Autowired
	ImportPayService importPayService;
	@Autowired
	RequestSubPayment requestSubPayment;
	
//	@PostMapping("/payschedule.do")
//	@Scheduled(cron = "0 0/5 * 1/1 * ? *")
	@GetMapping("schedule.do")
	public void payschedule(){
		// 현재 날짜가 수요일인 경우 실행
		LocalDate today = LocalDate.now();
		int todayDay = today.getDayOfWeek().getValue();
		// 1 -> 3으로 변경해야함
		if(todayDay == 1) {
			// 현재 날짜와 결제예정일이 일치하는 구독 조회
			List<Subscription> payLists = subscribeService.getPayList(today);
			log.debug("payList = {}", payLists);
			Map<String, Object> map = new HashMap<>();
			if(payLists != null) {
				String customerUid = "";
				String payName = "";
				int amount = 0;
				int result = 0;
				
				for(Subscription payList : payLists) {
					SubscriptionOrder subOrder = null;
					for(int i = 0; i < payLists.size(); i++) {
						// 결제용 고유번호 전달					
						int cardNo = payList.getCardInfoNo();
						CardInfo cardInfoList = subscribeService.getCardInfoList(cardNo);
						customerUid = cardInfoList.getCustomerUid();
						subOrder.setSoCardInfoNo(cardNo);
						
						String productCode = payList.getSProductCode();
						SubscriptionProduct product = subscribeService.getAmountByPcode(productCode);
						// 결제이름(정기구독 + 사이즈)
						payName = "정기구독 " + product.getSProductName();
						log.debug("payName = {}", payName);
						subOrder.setSoProductCode(productCode);
						
						// amount(가격)
						int sDeliveryFee = product.getSDeliveryFee();
						amount = product.getSProductPrice() + sDeliveryFee;
						log.debug("amount = {}", amount);
						subOrder.setSPrice(amount);
						
						// merchantUid(주문번호)
						String paymentDate = payList.getSPaymentDate().toString();
						String merchantUid = makemerchantUid(paymentDate);
						log.debug("merchantUid = {}", merchantUid);
						subOrder.setSOrderNo(merchantUid);;
						
						// payments again 진행
						map.put("customer_uid", customerUid);
						map.put("merchant_uid", merchantUid);
						map.put("amount", amount);
						map.put("name", payName);
						
						String response = requestSubPayment.requestPayAgain(map);
						log.debug("response = {}", response);
						
						JsonParser parser = new JsonParser();
						JsonElement element = parser.parse(response);
						int success = element.getAsJsonObject().get("code").getAsInt();
						log.debug("success = {}", success);
						
						String sNo = payList.getSNo();
						subOrder.setSNo(sNo);
						
						int times = 0;
						times = subscribeService.getTimesBysNo(sNo);
						if(times == 0) {
							subOrder.setSTimes(times); // 구독회차
						}
						else {
							subOrder.setSTimes(times + 1); // 구독회차
						}
						subOrder.setSoExcludeVegs(payList.getSExcludeVegs());
						subOrder.setSoDeliveryCycle(payList.getSDeliveryCycle());
						subOrder.setSoDeliveryDate(payList.getSNextDeliveryDate());
						subOrder.setSoDelayYn(payList.getSDelayYn());
						subOrder.setSNo(payList.getSRecipient());
						subOrder.setSoPhone(payList.getSPhone());
						subOrder.setSoAddress(payList.getSAddress());
						subOrder.setSoAddressEx(payList.getSAddressEx());
						subOrder.setSoDeliveryRequest(payList.getSDeliveryRequest());
						log.debug("subOrder = {}", subOrder);
						if(success == 0) { // 0이면 성공, 실패일 경우 0이 아닌 값 + message 
							result = subscribeService.insertSubOrder(subOrder);
						}
					}
				}
				log.debug("result = {}", result);
			}
		}
		return;
	}
	
	public String makemerchantUid(String paymentDate) {
		// 매번 변경되어야 하는 주문번호 - ex) SO + 220901(년월일) + 1201(시분) + 랜덤3자리 = 총 15자리
		// 1. 기존에는 시분 + 랜덤3자리였으나 예약결제는 시분은 없기때문에 랜덤 7자리로 변경
		String date = paymentDate.replaceAll("-", "");
		Random random = new Random();
		StringBuilder sb = new StringBuilder();
		
		final int len = 7;
		for(int i = 0; i < len; i++) {
			sb.append(random.nextInt(10));
		}
		String ran = sb.toString();
		log.debug("ran = {}", ran);
		
		return "SO" + date + ran;
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
	public void subscribeMain(Model model, Authentication authentication) {
		// 선아 추가(이미 구독중인 사람은 버튼 비활성화)
		if(authentication != null) {
			Member member = (Member) (authentication.getPrincipal());
			log.debug("plan member = {}", member);
			String isSubscribe = "";
			if(member != null) {
				isSubscribe = subscribeService.getSubscriptionByMemberId(member.getMemberId());
				if(isSubscribe != null)
					isSubscribe = "Y";
			}
			log.debug("isSubscribe = {}", isSubscribe);
			model.addAttribute("isSubscribe", isSubscribe);
		}
		
		double sReviewStarAvg = subscribeService.getSubscriptionReviewStarAvg();

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
	
	
	@GetMapping("/subscribeReviewRecommended.do")
	public ResponseEntity<?> subscribeReviewRecommended(@RequestParam String sReviewNo, @RequestParam String memberId) {
		log.debug("sReviewNo = {}", sReviewNo);
		log.debug("memberId = {}", memberId);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("sReviewNo", sReviewNo);
		log.debug("param = {}", param);
		
		int sRecommendedYn = subscribeService.getRecommendedYn(param);
		boolean recommended = sRecommendedYn == 1;
		log.debug("recommended = {}", recommended);
		
		return ResponseEntity.ok(recommended);
	}
	
	@PostMapping("/subscribeReviewRecommendAdd.do")
	public ResponseEntity<?> subscribeReviewRecommendAdd(@RequestParam String memberId, @RequestParam String sReviewNo) {
		log.debug("memberId = {}", memberId);
		log.debug("sReviewNo = {}", sReviewNo);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("sReviewNo", sReviewNo);
		int result = subscribeService.updateSubscribeReviewRecommendAdd(param);
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("/subscribeReviewRecommendCancel.do")
	public ResponseEntity<?> subscribeReviewRecommendCancel(@RequestParam String memberId, @RequestParam String sReviewNo) {
		log.debug("memberId = {}", memberId);
		log.debug("sReviewNo = {}", sReviewNo);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("sReviewNo", sReviewNo);
		int result = subscribeService.updateSubscribeReviewRecommendCancel(param);
		
		return ResponseEntity.ok(result);
	}
	// 미송코드 끝

}
