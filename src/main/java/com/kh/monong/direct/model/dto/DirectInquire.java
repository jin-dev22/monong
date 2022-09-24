package com.kh.monong.direct.model.dto;

import java.time.LocalDate;

import com.kh.monong.common.enums.YN;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@ToString(callSuper = true)
public class DirectInquire extends DirectInquireEntity {
	private String dProductName;
	private DirectInquireAnswer directInquireAnswer;
	
	public DirectInquire(long dInquireNo, String dProductNo, String memberId, String inquireTitle,
						String content, LocalDate createdAt, YN hasAnswer) {
		super(dInquireNo, dProductNo, memberId, inquireTitle, content, createdAt, hasAnswer);
	}
}
