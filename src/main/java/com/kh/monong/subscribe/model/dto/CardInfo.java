package com.kh.monong.subscribe.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CardInfo {
	private int cardInfoNo;
	private String cardNo; // 카드번호
	private String cardExpireDate; // 카드 유효기간(YYYY-MM)
	private String cardBirthDate; // 생년월일(6자리)
	private String cardPassword; // 카드 비번 앞2자리
	@NonNull
	private String customerUid; // 고객 고유번호(필수)
}
