package com.kh.monong.subscribe.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SubscriptionReviewAttachment {
	private int sAttachNo;
	private String sReviewNo;
	private String sReviewOriginalFilename;
	private String sReviewRenamedFilename;
	private LocalDateTime sReviewCreatedAt;
}
