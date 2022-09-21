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
public class CartEntity {
	@NonNull
	private String cartNo;
	@NonNull
	private String dOptionNo;
	@NonNull
	private String memberId;
	private int productCount;
}
