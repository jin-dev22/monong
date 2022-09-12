package com.kh.monong.subscribe.model.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SubscriptionOrder {
	private String sOrderNo; // 주문번호 SO + 220902 + 1726 + 123(15자리)
	@NonNull
	private String sNo;
	private int sTimes; // 구독회차
	private int sPrice; // 결제금액
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDateTime sOrderDate; // 결제일
	private String sOrderStatus; // 주문상태
}
