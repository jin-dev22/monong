package com.kh.monong.subscribe.model.dto;

import java.time.LocalDateTime;

import com.kh.monong.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class SubscriptionOrder extends Subscription {
	private String sOrderNo; // 주문번호 2209021726123(13자리)
	private int sTimes; // 구독회차
	private int sPrice; // 결제금액
	private LocalDateTime sOrderDate; // 결제일
	private String sOrderStatus; // 주문상태
	
	private Member member;
	private CardInfo cardInfo;
}
