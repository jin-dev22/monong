package com.kh.monong.subscribe.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SubscriptionReview {
	private String sReviewNo;
	private String sOrderNo;
	private String sReviewTitle;
	private String sReviewContent;
	private int sReviewStar;
	private int sReviewRecommendNum;
	private LocalDateTime sReviewCreatedAt;
	private LocalDateTime sReviewUpdatedAt;
	
	private List<SubscriptionReviewAttachment> sAttachments = new ArrayList<>();
}
