package com.kh.monong.subscribe.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.subscribe.model.dao.SubscribeDao;
import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;

import lombok.NonNull;

@Service
public class SubscribeServiceImpl implements SubscribeService {
	
	@Autowired
	SubscribeDao subscribeDao;
	// 선아코드 시작
	@Override
	public int insertCardInfo(CardInfo cardInfo) {
		return subscribeDao.insertCardInfo(cardInfo);
	}
	
	@Override
	public CardInfo findCardInfoByUid(@NonNull String customerUid) {
		return subscribeDao.findCardInfoByUid(customerUid);
	}
	
	@Override
	public int insertSubscription(Subscription subscription, int cardInfoNo) {
		return subscribeDao.insertSubscription(subscription, cardInfoNo);
	}
	
	@Override
	public int findCardInfoNoByUid(String customerUid) {
		return subscribeDao.findCardInfoNoByUid(customerUid);
	}
	
	// 선아코드 끝
		
	// 미송코드 시작
	// 미송코드 끝
}
