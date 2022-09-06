package com.kh.monong.member.model.dto;

import org.springframework.lang.NonNull;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
public class SellerInfoAttachment {
	private int sellerAttachNo;
	@NonNull
	private String memberId;
	@NonNull
	private String originalFilename;
	@NonNull
	private String renamedFilename;
}
