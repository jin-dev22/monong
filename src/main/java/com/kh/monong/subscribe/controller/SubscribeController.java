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
import com.kh.monong.common.enums.YN;
import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.service.MemberService;
import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.Vegetables;
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
	/**
	 * 주문결제 페이지
	 */
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
	/**
	 * 카드정보 저장
	 */
	@PostMapping("/insertCardInfo.do")
	public ResponseEntity<?> insertCardInfo(
			@RequestParam String customerUid, CardInfo cardInfo
			) {
		return ResponseEntity.ok(subscribeService.insertCardInfo(cardInfo));
	}
	/**
	 * 구독정보 저장
	 */
	@PostMapping("/subComplete.do")
	public String insertSubOrder(
			@RequestParam String sNo,
			@RequestParam String customerUid,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate sNextDeliveryDate,
			Subscription subscription,
			RedirectAttributes redirectAttr
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
	
	/**
	 * 구독 완료 페이지
	 */
	@GetMapping("/subComplate.do")
	public void subComplete(Authentication authentication, Model model) {
		List<SubscriptionProduct> subscriptionProduct = subscribeService.getSubscriptionProduct();
		model.addAttribute("subscriptionProduct", subscriptionProduct);
	}
	
	/**
	 * 스케줄 관련 메소드
	 */
	// 스케줄
	@Autowired
	RequestSubPayment requestSubPayment;
	
	/**
	 * servlet-context.xml에 schedule task 추가
	 * - 매주 수요일에 실행하도록 설정
	 */
	public void payschedule(){
		LocalDate today = LocalDate.now();
		int todayDay = today.getDayOfWeek().getValue();
		// 오늘이 수요일인 경우 스케쥴 진행되며 한 번 더 확인
		if(todayDay == 3) {
			// 현재 날짜와 결제예정일이 일치하는 구독 조회
			List<Subscription> payLists = subscribeService.getPayList(today);
//			log.debug("payLists = {}", payLists);
			Map<String, Object> map = new HashMap<>();
			if(payLists != null) {
				String customerUid = "";
				String payName = "";
				int amount = 0;
				int cycle = 0;
				int result = 0;
				YN delayYn = YN.N; // 기본값
				
				for(Subscription payList : payLists) {
					SubscriptionOrder subOrder = new SubscriptionOrder();
					// 결제용 고유번호 전달					
					int cardNo = payList.getCardInfoNo();
					CardInfo cardInfoList = subscribeService.getCardInfoList(cardNo);
					customerUid = cardInfoList.getCustomerUid();
					subOrder.setSoCardInfoNo(cardNo);
					
					String productCode = payList.getSProductCode();
					SubscriptionProduct product = subscribeService.getAmountByPcode(productCode);
					
					// 결제이름(정기구독 + 사이즈)
					payName = "정기구독 " + product.getSProductName();
					subOrder.setSoProductCode(productCode);
					
					// amount(가격)
					int sDeliveryFee = product.getSDeliveryFee();
					amount = product.getSProductPrice() + sDeliveryFee;
					subOrder.setSPrice(amount);
					
					// merchantUid(주문번호)
					String paymentDate = payList.getSPaymentDate().toString();
					String merchantUid = makemerchantUid(paymentDate);
					subOrder.setSOrderNo(merchantUid);;
					
					// payments again 진행
					map.put("customer_uid", customerUid);
					map.put("merchant_uid", merchantUid);
					map.put("amount", amount);
					map.put("name", payName);
					
					// iamport에 rest api를 통해 결제 진행
					String response = requestSubPayment.requestPayAgain(map);
					
					// 결제에 대한 json 결과값의 내용을 변환하여 꺼내기
					JsonParser parser = new JsonParser();
					JsonElement element = parser.parse(response);
					int success = element.getAsJsonObject().get("code").getAsInt();
					
					String sNo = payList.getSNo();
					subOrder.setSNo(sNo);
					
					// 현재 구독 회수 조회
					SubscriptionOrder isExists = subscribeService.getTimesBysNo(sNo);
					int times = 1;
					if(isExists == null) {
						subOrder.setSTimes(times); // null이면 첫 구독 결제
					}
					else {
						times = isExists.getSTimes();
						subOrder.setSTimes(times + 1);
					}
					
					subOrder.setSoExcludeVegs(payList.getSExcludeVegs());
					cycle = payList.getSDeliveryCycle();
					subOrder.setSoDeliveryCycle(cycle);
					subOrder.setSoDeliveryDate(payList.getSNextDeliveryDate());
					delayYn = payList.getSDelayYn();
					subOrder.setSoDelayYn(delayYn);
					subOrder.setSoRecipient(payList.getSRecipient());
					subOrder.setSoPhone(payList.getSPhone());
					subOrder.setSoAddress(payList.getSAddress());
					subOrder.setSoAddressEx(payList.getSAddressEx());
					subOrder.setSoDeliveryRequest(payList.getSDeliveryRequest());
					
					// success가 0이면 성공, 실패일 경우 0이 아닌 값 + message
					if(success == 0) { 
						result = subscribeService.insertSubOrder(subOrder);
					}
					
					// 결제 완료 후 미루기여부/다음배송일/다음결제예정일 update
					if(result == 1) {
						// 미루기 완료 후 결제가 되었기 때문에 다시 N으로 변경
						if("Y".equals(delayYn))
							delayYn = YN.N;
						LocalDate currPaymentDate = payList.getSPaymentDate();
						LocalDate currDeliveryDate = payList.getSNextDeliveryDate();
						
						int plusDay = cycle * 7;
						LocalDate nextPaymentDate = currPaymentDate.plusDays(plusDay);
						LocalDate nextDeliveryDate = currDeliveryDate.plusDays(plusDay);
						
						Subscription updateSub = Subscription.builder()
															.sNo(sNo)
															.sDelayYn(delayYn)
															.sPaymentDate(nextPaymentDate)
															.sNextDeliveryDate(nextDeliveryDate)
															.build();
						result = subscribeService.updateSubscriptionSuccessPay(updateSub);
					}
				}
				if(result == 1) {
					log.debug("구독 완료");
				}
			}
		}
	}
	
	/**
	 * merchantUid(주문번호) 생성 메소드
	 * - 주문번호는 매번 변경되어 전달해야 한다.
	 * - ex) SO + 220901(년월일) + 랜덤 7자리 = 총 15자리
	 * - 기존에는 SO + 220901(년월일) + 1201(시분) + 랜덤3자리 이었으나
	 *   스케줄로 인해 거의 비슷한 시분에 결제가 진행되어 겹칠 위험이 있으므로 랜덤 7자리로 변경
	 */
	public String makemerchantUid(String paymentDate) {
		String date = paymentDate.replaceAll("-", "");
		date = date.substring(2);
		Random random = new Random();
		StringBuilder sb = new StringBuilder();
		
		final int len = 7;
		for(int i = 0; i < len; i++) {
			sb.append(random.nextInt(10));
		}
		String ran = sb.toString();
		
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
