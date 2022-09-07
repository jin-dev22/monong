package com.kh.monong.subscribe.model.service;


import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import lombok.NonNull;
import java.util.List;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.Vegetables;

public interface SubscribeService {

	// 선아코드 시작
	int insertCardInfo(CardInfo cardInfo);

	CardInfo findCardInfoByUid(@NonNull String customerUid);

	int insertSubscription(Subscription subscription, int cardInfoNo);

	int findCardInfoNoByUid(String customerUid);
	
	SubscriptionProduct selectProductInfoByCode(String sProduct);
	
	
	// 선아코드 끝
		
	// 미송코드 시작
	List<SubscriptionProduct> getSubscriptionProduct();
	
	List<Vegetables> getVegetables();
	// 미송코드 끝


}
