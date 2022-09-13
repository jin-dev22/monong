package com.kh.monong.member.model.dto;

import java.time.LocalDate;

import com.kh.monong.common.enums.YN;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@ToString(callSuper = true) 
public class Seller extends Member{
	private SellerInfo sellerInfo;
	private SellerInfoAttachment attachment;
	
	public Seller(String memberId, String memberName, String memberPassword, String memberEmail, String memberAddress,
			String memberAddressEx, String memberPhone, LocalDate memberBirthday, YN memberDel, LocalDate memberEnrollDate,
			 LocalDate memberQuitDate, YN memberIdentified) {
		super();
	}
	
	
}
