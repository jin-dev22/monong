package com.kh.monong.direct.model.dto;

import org.springframework.lang.NonNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DirectProductOption {
//	@NonNull
	private String dOptionNo;
	@NonNull
	private String dProductNo;
	private String dOptionName;
	private String dSaleStatus;
	private int dPrice;
	private int dStock;
}
