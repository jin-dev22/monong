package com.kh.monong.member.model.dto;

import org.springframework.lang.NonNull;

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
	private SellerInfo sellerInfo;
	private SellerInfoAttachment attachment;
}
