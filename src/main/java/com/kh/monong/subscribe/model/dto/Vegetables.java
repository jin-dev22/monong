package com.kh.monong.subscribe.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Vegetables {
	private String vegCode;
	private String vegCategory;
	private String vegName;
}
