package com.kh.monong.subscribe.model.dto;

import java.time.LocalDate;

import com.kh.monong.common.enums.YN;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Subscription {
	private String sNo;
	private String memberId;
	private String sProductCode;
	private String sExcludeVegs;
	private int sDeliveryCycle;
	private LocalDate sNextDeliveryDate;
	private YN sDelayYn;
	private String sRecipient;
	private String sPhone;
	private String sAddress;
	private String sAddressEx;
	private String sDeliveryRequest;	
	private int cardInfoNo; // 카드정보번호
}
