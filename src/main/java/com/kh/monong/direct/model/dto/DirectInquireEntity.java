package com.kh.monong.direct.model.dto;

import java.time.LocalDate;

import com.kh.monong.common.enums.YN;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class DirectInquireEntity {
	private long dInquireNo;
	@NonNull
	private String dProductNo;
	@NonNull
	private String memberId;
	@NonNull
	private String inquireTitle;
	private String content;
	private LocalDate createdAt;
	private YN hasAnswer;
}