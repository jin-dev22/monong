package com.kh.monong.inquire.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@ToString
public class InquireAnswer {
	private String inquireANo;
	private String inquireNo;
	private String inquireAContent;
	private LocalDate inquireAnsweredAt;
}
