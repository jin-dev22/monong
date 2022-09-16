package com.kh.monong.subscribe.model.service;


import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;

import lombok.NonNull;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.Vegetables;

public interface SubscribeService {

	// 선아코드 시작
	int insertCardInfo(CardInfo cardInfo);

	int insertSubscription(Subscription subscription);

	int findCardInfoNoByUid(String customerUid);
	
	Subscription selectSubscription(String sNo);
	
	SubscriptionProduct selectProductInfoByCode(String sProduct);
	
	Subscription findNextDeliveryDateByUid(String customerUid);
	
	
	
	// 선아코드 끝
		
	// 미송코드 시작
	List<SubscriptionProduct> getSubscriptionProduct();
	
	List<Vegetables> getVegetables();

	int getSubscriptionReviewStarAvg();
	
	int getTotalContent();
	
	List<SubscriptionReview> selectSubscriptionReviewList(Map<String, Integer> param);
	
	SubscriptionReview selectOneSubscriptionReview(String reviewNo);
	
	int updateSubscribeReviewRecommend(String sReviewNo);
	
	// 추가
	String getSubscriptionByMemberId(String memberId);
	
	// 미송코드 끝


}
