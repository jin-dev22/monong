package com.kh.monong.subscribe.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SubscriptionProduct {
	private String sProductCode; // 상품코드 SP1, SP2, SP3
	private String sProductName; // 상품명
	private String sProductInfo; // 상품설명
	private int sProductPrice; // 상품가격
	private static int SDELIVERYFEE = 3000; // 배송비 고정
}
