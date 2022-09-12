package com.kh.monong.subscribe.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.PeriodicTrigger;
import org.springframework.stereotype.Component;

import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.service.SubscribeService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ReqPayScheduler {
	
	private ThreadPoolTaskScheduler scheduler;
	
	@Autowired
	private SubscribeService subscribeService;
	
	
	// 구독 취소 - scheduler shutdown을 통해 결제 요청 멈춤
	public void stopScheduler() {
		scheduler.shutdown();
	}
	
	public void startScheduler(String customerUid, int amount, String merchantUid) {
		scheduler = new ThreadPoolTaskScheduler();
		scheduler.initialize();
		// 스케줄 시작
		scheduler.schedule(getRunnable(customerUid, amount, merchantUid), getTrigger());
	}
	
    private Runnable getRunnable(String customerUid, int amount, String merchantUid){
    	Subscription subscription = subscribeService.findNextDeliveryDateByUid(customerUid);
		LocalDate nextDeliveryDate = subscription.getSNextDeliveryDate();
		log.debug("Runnable nextDeliveryDate = {}", nextDeliveryDate);
		
//		Calendar cal = Calendar.getInstance();
//		cal.add(Calendar.MONTH, 1);
//		cal.add(Calendar.DATE, 1);
//		Date s = convertFromJAVADateToSQLDate(cal.getTime());
		return () -> {
			// 결제는 아직 상품준비중이라면 return, 배송중이라면 nextDeliveryDate(금) + 5일뒤 결제하도록 스케쥴 지정
//        	setSchedulePay.schedulePay(customer_uid, price);
        	// 
        	// SubscriptionOrder 새로운 주문번호 insert
        	
        	// Subscription 다음배송일 sNextDeliveryDate update
        	// 만약 sDelayYn = Y라면 +7일 후 N으로 update
//			deliService.deliveryInsert(packageId,customer_uid,s);
        };
    }
    
    // 작업 주기 설정 
    private Trigger getTrigger() {
    	return new PeriodicTrigger(1, TimeUnit.MINUTES);
    }
    
}