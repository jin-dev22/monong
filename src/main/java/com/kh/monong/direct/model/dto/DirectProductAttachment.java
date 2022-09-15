package com.kh.monong.direct.model.dto;

import java.time.LocalDateTime;

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
public class DirectProductAttachment {
	private int dProductAttachNo;
	private String dProductNo;
	@NonNull
	private String dProductOriginalFilename;
	@NonNull
	private String dProductRenamedFilename;
}
