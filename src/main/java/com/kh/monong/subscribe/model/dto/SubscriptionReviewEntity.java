package com.kh.monong.subscribe.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
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
