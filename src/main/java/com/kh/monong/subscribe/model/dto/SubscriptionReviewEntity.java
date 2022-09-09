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
public class SubscriptionReviewEntity {
	private String sReviewNo;
	private String sOrderNo;
	private String sReviewContent;
	private int sReviewStar;
	private int sReviewRecommendNum;
	private LocalDateTime sReviewCreatedAt;
	private LocalDateTime sReviewUpdatedAt;
	
}
