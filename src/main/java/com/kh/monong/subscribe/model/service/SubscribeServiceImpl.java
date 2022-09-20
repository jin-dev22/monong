package com.kh.monong.subscribe.model.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.monong.subscribe.model.dao.SubscribeDao;
import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.Vegetables;

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
	public int insertSubscription(Subscription subscription) {
		return subscribeDao.insertSubscription(subscription);
	}
	
	@Override
	public Subscription selectSubscription(String sNo) {
		return subscribeDao.selectSubscription(sNo);
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
	public List<Subscription> getPayList(LocalDate today) {
		return subscribeDao.getPayList(today);
	}
	
	@Override
	public CardInfo getCardInfoList(int cardNo) {
		return subscribeDao.getCardInfoList(cardNo);
	}
	
	@Override
	public SubscriptionProduct getAmountByPcode(String sProductCode) {
		return subscribeDao.getAmountByPcode(sProductCode);
	}
	
	@Override
	public SubscriptionOrder getTimesBysNo(String sNo) {
		return subscribeDao.getTimesBysNo(sNo);
	}
	
	@Override
	public int insertSubOrder(SubscriptionOrder subOrder) {
		return subscribeDao.insertSubOrder(subOrder);
	}
	
	@Override
	public int updateSubscriptionSuccessPay(Subscription updateSub) {
		return subscribeDao.updateSubscriptionSuccessPay(updateSub);
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
	public double getSubscriptionReviewStarAvg() {
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
	public int getRecommendedYn(Map<String, String> param) {
		return subscribeDao.getRecommendedYn(param);
	}
	
	@Override
	public int updateSubscribeReviewRecommendAdd(Map<String, String> param) {
		int result = subscribeDao.updateSubscribeReviewRecommendAdd(param);
		result = subscribeDao.insertRecommendedSubscribeReview(param);
		return result;
	}
	
	@Override
	public int updateSubscribeReviewRecommendCancel(Map<String, String> param) {
		int result = subscribeDao.updateSubscribeReviewRecommendCancel(param);
		result = subscribeDao.deleteRecommendedSubscribeReview(param);
		return result;
	}
	
	@Override
	public String getSubscriptionByMemberId(String memberId) {
		return subscribeDao.getSubscriptionByMemberId(memberId);
	}
	// 미송코드 끝
}
