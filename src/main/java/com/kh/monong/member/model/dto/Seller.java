package com.kh.monong.member.model.dto;

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
@ToString(callSuper = true) 
public class Seller extends Member{
	//private String sellerId;//memberId
	private String sellerRegNo;
	private String sellerName;
	private SellerStatus sellerStatus;
	private LocalDate sellerQuitDate;
	private LocalDate sellerEnrollDate;
	private YN sellerDel; 
}
