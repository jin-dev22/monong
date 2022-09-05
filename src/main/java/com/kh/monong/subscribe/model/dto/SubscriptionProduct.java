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
	private String sProductCode;
	private String sProductName;
	private String sProductInfo;
	private int sProductPrice;
	private static int SDELIVERYFEE = 3000;

}
