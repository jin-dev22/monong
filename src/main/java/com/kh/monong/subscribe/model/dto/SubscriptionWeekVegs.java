package com.kh.monong.subscribe.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SubscriptionWeekVegs { // 정기구독 주별 채소 구성
	private String weekCriterion; // 기준일(월요일)
	private String vegComposition; // 채소명
}
