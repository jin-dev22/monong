package com.kh.monong.direct.model.dto;

import java.time.LocalDateTime;

import org.springframework.lang.NonNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DirectReviewAttachment {
	
	private int dReviewAttachNo;
	
	private String dReviewNo;
	@NonNull
	private String dReviewOriginalFilename;
	@NonNull
	private String dReviewRenamedFilename;
	private LocalDateTime dReviewCreatedAt;
}
