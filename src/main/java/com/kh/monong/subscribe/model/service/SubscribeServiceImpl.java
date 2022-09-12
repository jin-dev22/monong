package com.kh.monong.subscribe.model.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.monong.subscribe.model.dao.SubscribeDao;
import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.Vegetables;

import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class SubscribeServiceImpl implements SubscribeService {
	
	@Autowired
	private SubscribeDao subscribeDao;
	
	// 선아코드 시작
	@Override
	public int insertCardInfo(CardInfo cardInfo) {
		return subscribeDao.insertCardInfo(cardInfo);
	}
	
	@Override
	public int insertSubscription(SubscriptionOrder subscriptionOrder, Subscription subscription) {
		int result = subscribeDao.insertSubscription(subscription);
		result = subscribeDao.insertSubscriptionOrder(subscriptionOrder);
		return result;
	}
	
	@Override
	public SubscriptionOrder selectSubscriptionOrderRecent(String sNo) {
		return subscribeDao.selectSubscriptionOrderRecent(sNo);
	}
	
	@Override
	public int findCardInfoNoByUid(String customerUid) {
		return subscribeDao.findCardInfoNoByUid(customerUid);
	}
	
	@Override
	public SubscriptionProduct selectProductInfoByCode(String sProductCode) {
		return subscribeDao.selectProductInfoByCode(sProductCode);
	}
	
	@Override
	public Subscription findNextDeliveryDateByUid(String customerUid) {
		return subscribeDao.findNextDeliveryDateByUid(customerUid);
	}
	
	
	// 선아코드 끝
		
	// 미송코드 시작
	@Override
	public List<SubscriptionProduct> getSubscriptionProduct() {
		return subscribeDao.getSubscriptionProduct();
	}
	
	@Override
	public List<Vegetables> getVegetables() {
		return subscribeDao.getVegetables();
	}
	// 미송코드 끝
}
