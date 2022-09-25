package com.kh.monong.subscribe.model.service;

import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.SubscriptionWeekVegs;
import com.kh.monong.subscribe.model.dto.Vegetables;

public interface SubscribeService {

	// 선아코드 시작
	int insertCardInfo(CardInfo cardInfo);

	int insertSubscription(Subscription subscription);

	int findCardInfoNoByUid(String customerUid);
	
	Subscription selectSubscription(String sNo);
	
	SubscriptionProduct selectProductInfoByCode(String sProduct);
	
	List<Subscription> getPayList(LocalDate today);
	
	CardInfo getCardInfoList(int cardNo);
	
	SubscriptionProduct getAmountByPcode(String sProductCode);
	
	SubscriptionOrder getTimesBysNo(String sNo);

	int insertSubOrder(SubscriptionOrder subOrder);
	
	int updateSubscriptionSuccessPay(Subscription updateSub);
	
	/**
	 * 관리자
	 */
	List<Subscription> getSubscriptionListAll(Map<String, Integer> param);

	int getTotalSubscriptionListAll();
	
	List<Subscription> findByQuitYnSubList(String selectOption, Map<String, Integer> param);

	int getTotalFindByQuitYnSubList(String selectOption);
	
	List<SubscriptionOrder> getSubscriptionOrderListAll(Map<String, Object> param);

	int getTotalSubscriptionOrderListAll(String deliveryStatus);
	
	int updateSubDelivery(Map<String, Object> param);

	List<SubscriptionOrder> getSubOrderList(LocalDate today);
	
	List<SubscriptionOrder> searchPeriodData(Map<String, Object> param);

	int getTotalsearchPeriodData(Map<String, Object> param);
	
	List<SubscriptionOrder> getSubscriptionListBySubNo(Map<String, Object> param);

	int getTotalSubscriptionListBySubNo(String subNo);
	
	/**
	 * 주간채소 팝업
	 */
	SubscriptionWeekVegs getWeekVegsNotice(String weekCriterion);
	
	SubscriptionWeekVegs getRecentWeekVegsNotice();
	
	
	
	// 선아코드 끝
		
	// 미송코드 시작
	List<SubscriptionProduct> getSubscriptionProduct();
	
	List<Vegetables> getVegetables();

	double getSubscriptionReviewStarAvg();
	
	int getTotalContent();
	
	List<SubscriptionReview> selectSubscriptionReviewList(Map<String, Integer> param);
	
	SubscriptionReview selectOneSubscriptionReview(String reviewNo);
	
	int getRecommendedYn(Map<String, String> param);

	int updateSubscribeReviewRecommendAdd(Map<String, String> param);
	
	int updateSubscribeReviewRecommendCancel(Map<String, String> param);
	
	// 추가
	String getSubscriptionByMemberId(String memberId);
	
	
	
	
	// 미송코드 끝

	//수아코드 시작
	int insertSubscriptionWeekVegs(SubscriptionWeekVegs subscriptionWeekVegs);
	
	int getTotalSubscriptionWeekVegsContent();
	
	List<SubscriptionWeekVegs> selectSubscriptionWeekVegsList(Map<String, Integer> param);
	
	SubscriptionWeekVegs selectOneSubscriptionWeekVegs(String weekCriterion);
	
	int updateSubscriptionWeekVegs(SubscriptionWeekVegs subscriptionWeekVegs);
	//수아코드 끝

	//수진코드 시작
	String selectMemberIdBySoNo(String subOrderNo);
	//수진코드 끝



}
