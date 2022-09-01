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
public class DirectInquireAnswer {
	@NonNull
	private String dInquireNo;
	@NonNull
	private String dInquireAContent;
	private LocalDateTime dInquireCreatedAt;
}
