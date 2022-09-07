package com.kh.monong.subscribe.model.service;

import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;

import lombok.NonNull;

public interface SubscribeService {

	// 선아코드 시작
	int insertCardInfo(CardInfo cardInfo);

	CardInfo findCardInfoByUid(@NonNull String customerUid);

	int insertSubscription(Subscription subscription, int cardInfoNo);

	int findCardInfoNoByUid(String customerUid);
	
	
	
	// 선아코드 끝
		
	// 미송코드 시작
	// 미송코드 끝
}
