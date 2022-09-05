package com.kh.monong.member.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.NonNull;

import com.kh.monong.common.enums.YN;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberEntity {
	@NonNull
	protected String memberId;
	@NonNull
	protected String memberName;
	@NonNull
	protected String memberPassword;
	@NonNull
	protected String memberEmail;
	@NonNull
	protected String memberAddress;
	protected String memberAddressEx;
	@NonNull
	protected String memberPhone;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDate memberBirthday;
	protected YN memberDel;
	protected LocalDate memberEnrollDate;
	protected LocalDate memberQuitDate;
}
