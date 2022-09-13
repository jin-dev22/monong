package com.kh.monong.subscribe.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.kh.monong.subscribe.model.dao.SubscribeDao;
import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import lombok.NonNull;

import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.Vegetables;

@Service
public class SubscribeServiceImpl implements SubscribeService {
	
	@Autowired
	private SubscribeDao subscribeDao;
	
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
	
	@Override
	public SubscriptionProduct selectProductInfoByCode(String sProductCode) {
		return subscribeDao.selectProductInfoByCode(sProductCode);
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
	
	@Override
	public int getSubscriptionReviewStarAvg() {
		return subscribeDao.getSubscriptionReviewStarAvg();
	}
	
	@Override
	public int getTotalContent() {
		return subscribeDao.getTotalContent();
	}
	
	@Override
	public List<SubscriptionReview> selectSubscriptionReviewList(Map<String, Integer> param) {
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return subscribeDao.selectSubscriptionReviewListCollection(rowBounds);
	}
	
	@Override
	public SubscriptionReview selectOneSubscriptionReview(String sReviewNo) {
		return subscribeDao.selectOneSubscriptionReviewCollection(sReviewNo);
	}
	
	@Override
	public int updateSubscribeReviewRecommend(String sReviewNo) {
		return subscribeDao.updateSubscribeReviewRecommend(sReviewNo);
	}
	// 미송코드 끝
}
