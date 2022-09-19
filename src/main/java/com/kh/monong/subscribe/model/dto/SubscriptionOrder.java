package com.kh.monong.subscribe.model.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.kh.monong.common.enums.YN;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

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
	private LocalDate sOrderDate; // 결제일(수요일)
	private String sOrderStatus; // 주문상태 기본값 상품준비중
	private int soCardInfoNo; // 카드정보번호
	private String soProductCode; // 상품코드
	private String soExcludeVegs; // 제외채소
	private int soDeliveryCycle; // 배송주기
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate soDeliveryDate; // 해당 주문건 배송일
	private YN soDelayYn; // 미루기여부
	private String soRecipient; // 수령자명
	private String soPhone; // 수령자 연락처
	private String soAddress; // 수령자 배송지
	private String soAddressEx; // 수령자 상세배송지
	private String soDeliveryRequest; //배송요청사항
	// 9/20 추가
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate soDeliveryCompletedDate; // 배송완료일 
}
