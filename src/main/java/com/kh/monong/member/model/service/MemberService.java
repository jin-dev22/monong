package com.kh.monong.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.MemberEntity;
import com.kh.monong.member.model.dto.Seller;
import com.kh.monong.member.model.dto.SellerInfo;
import com.kh.monong.member.model.dto.SellerInfoAttachment;

public interface MemberService {
//-----------수진시작
	Member selectMemberById(String memberId);
	
	Member selectMemberByEmail(String email);
	
	int insertMember(Map<String, Object> memberAuthMap, Member member);
	
	int insertMemberAuth(Map<String, Object> memberAuthMap);
	
	int insertEmailIdentify(Map<String, Object> map);
	
	String getEmailKey(String email);
	
	
	int insertSeller(Map<String, Object> memberAuthMap, Seller seller);

	int insertSellerInfo(SellerInfo sellerInfo);
	
	int insertSellerInfoAttachment(SellerInfoAttachment attachment);
	
	SellerInfo selectSellerInfo(String memberId);
//-----------수진 끝
//-----------수아 시작
	Member findMemberId(Map<String, Object> map);

	int updateTempPw(Map<String, Object> map);
	
	int updateMember(Member member);

	int updatePw(Map<String, Object> map);
	
//-----------수아 끝


	

	
}
