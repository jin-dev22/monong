package com.kh.monong.direct.model.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.NonNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DirectOrder {
	@NonNull
	private String dOrderNo;
	@NonNull
	private String memberId;
	@NonNull
	private int dTotalPrice;
	@NonNull
	private String dDestAddress;
	private String dDestAddressEx;
	private String dDeliveryRequest;
	@NonNull
	private String dRecipient;
	@NonNull
	private String dOrderPhone;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NonNull
	private LocalDateTime dOrderDate;
	@NonNull
	private String dPayments;
	@NonNull
	private DOrderStatus dOrderStatus;
}
