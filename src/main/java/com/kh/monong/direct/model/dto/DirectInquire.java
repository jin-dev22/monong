package com.kh.monong.direct.model.dto;

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
}
