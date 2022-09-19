package com.kh.monong.subscribe.model.dto;

import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;
import com.kh.monong.common.enums.YN;

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
public class Subscription {
	private String sNo; // 구독번호 S + 220902 + 12345 12자리
	private String memberId; // 회원아이디
	private String sProductCode; // 상품코드
	private String sExcludeVegs; // 제외채소
	private int sDeliveryCycle; // 배송주기
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate sNextDeliveryDate; // 다음배송일
	private YN sDelayYn; // 미루기여부
	private String sRecipient; // 수령자명
	private String sPhone; // 수령자 연락처
	private String sAddress; // 수령자 배송지
	private String sAddressEx; // 수령자 상세배송지
	private String sDeliveryRequest; //배송요청사항
	private int cardInfoNo; // 카드정보번호
	private YN sQuitYn; // 구독취소여부(9/13 추가)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate sPaymentDate; // 결제예정일-수요일(9/15 추가)
}