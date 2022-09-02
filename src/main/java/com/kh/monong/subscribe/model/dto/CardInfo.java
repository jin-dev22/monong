package com.kh.monong.subscribe.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CardInfo {
	private int cardInfoNo;
	private String cardNo;
	private String cardExpireDate;
	private String cardBirthDate;
	private String cardPassword;
	private String customerUid;
}
