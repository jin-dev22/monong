package com.kh.monong.subscribe.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@ToString(callSuper = true)
public class SubscriptionReview extends SubscriptionReviewEntity {
	private String memberId;
	private int sTimes;
	private List<SubscriptionReviewAttachment> sAttachments = new ArrayList<>();
	
	public SubscriptionReview(String sReviewNo, String sOrderNo, String sReviewContent, int sReviewStar,
			int sReviewRecommendNum, LocalDateTime sReviewCreatedAt, LocalDateTime sReviewUpdatedAt, String memberId,
			int sTimes, List<SubscriptionReviewAttachment> sAttachments) {
		super(sReviewNo, sOrderNo, sReviewContent, sReviewStar, sReviewRecommendNum, sReviewCreatedAt,
				sReviewUpdatedAt);
		this.memberId = memberId;
		this.sTimes = sTimes;
		this.sAttachments = sAttachments;
	}	
	
	public void add(SubscriptionReviewAttachment attach) {
		this.sAttachments.add(attach);
	}
}
