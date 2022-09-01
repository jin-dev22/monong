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
public class DirectProductAttachment {
	@NonNull
	private int dProductAttachNo;
	@NonNull
	private String dProductNo;
	private String dProductOriginalFilename;
	private String dProductRenamedFilename;
}
