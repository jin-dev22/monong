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
public class DirectReview {
	@NonNull
	private String dReviewNo;
	@NonNull
	private String dOptionNo;
	@NonNull
	private String dOrderNo;
	@NonNull
	private String dReviewTitle;
	@NonNull
	private String memberId;
	@NonNull
	private String dReviewContent;
	private int reviewRating;
	private int dReviewRecommend;
	private LocalDateTime dReviewCreatedAt;
	private LocalDateTime dReviewUpdatedAt;
}
