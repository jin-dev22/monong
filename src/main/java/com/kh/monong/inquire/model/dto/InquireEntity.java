package com.kh.monong.inquire.model.dto;

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
public class InquireEntity {
	private String inquireNo;
	@NonNull
	private String memberId;
	@NonNull
	private String inquireTitle;
	private String inquireContent;
	private LocalDate inquireCreatedAt;
	private YN hasAnswer;
}
