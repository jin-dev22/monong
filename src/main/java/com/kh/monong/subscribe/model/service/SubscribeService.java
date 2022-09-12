package com.kh.monong.subscribe.model.service;


import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;

import lombok.NonNull;

import java.time.LocalDate;
import java.util.List;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.Vegetables;

public interface SubscribeService {

	// 선아코드 시작
	int insertCardInfo(CardInfo cardInfo);

	int insertSubscription(SubscriptionOrder subscriptionOrder, Subscription subscription);

	int findCardInfoNoByUid(String customerUid);
	
	SubscriptionOrder selectSubscriptionOrderRecent(String sNo);
	
	SubscriptionProduct selectProductInfoByCode(String sProduct);
	
	Subscription findNextDeliveryDateByUid(String customerUid);
	
	
	
	// 선아코드 끝
		
	// 미송코드 시작
	List<SubscriptionProduct> getSubscriptionProduct();
	
	List<Vegetables> getVegetables();
	
	List<SubscriptionReview> selectSubscriptionReviewList();
	// 미송코드 끝



}
