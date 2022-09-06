package com.kh.monong.subscribe.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.subscribe.model.dao.SubscribeDao;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.Vegetables;

@Service
public class SubscribeServiceImpl implements SubscribeService {
	
	@Autowired
	private SubscribeDao subscribeDao;
	
	// 선아코드 시작
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
