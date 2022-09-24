package com.kh.monong.direct.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@ToString
public class DirectInquireAnswer {
	@NonNull
	private long dInquireNo;
	private String dInquireAContent;
	private LocalDate dInquireAnsweredAt;
}
