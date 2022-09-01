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
public class DirectInquire {
	@NonNull
	private String dInquireNo;
	@NonNull
	private String dProductNo;
	@NonNull
	private String memberId;
	private String inquireTitle;
	@NonNull
	private String content;
	private LocalDateTime createdAt;
	@NonNull
	private Status status;
}
