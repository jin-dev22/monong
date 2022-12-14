package com.kh.monong.member.model.dto;

import org.springframework.lang.NonNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
public class SellerInfoAttachment {
	private long sellerAttachNo;
	@NonNull
	private String memberId;
	@NonNull
	private String originalFilename;
	@NonNull
	private String renamedFilename;
}
