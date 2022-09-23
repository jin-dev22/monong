package com.kh.monong.notice.model.dto;

import java.time.LocalDate;

import com.kh.monong.common.enums.YN;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberNotification {
	private long notiNo;
	private String memberId;
	private String notiContent;
	private LocalDate notiCreadtedAt;
	private YN notiIsRead;
	private long inquireNo;//관리자문의
	private String dInquireNo;//직거래 판매자문의
	private String dOrderNo;
	private String sOrderNo;//정기구독번호
	private MessageType messageType; 
}
