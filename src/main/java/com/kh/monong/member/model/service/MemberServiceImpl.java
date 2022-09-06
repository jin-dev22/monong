package com.kh.monong.member.model.service;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.monong.member.model.dao.MemberDao;
import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.Seller;
import com.kh.monong.member.model.dto.SellerInfo;
import com.kh.monong.member.model.dto.SellerInfoAttachment;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	//------------------수진 시작
	@Override
	public Member selectMemberById(String memberId) {
		return memberDao.selectMemberById(memberId);
	}
	
	@Override
	public Member selectMemberByEmail(String email) {
		return memberDao.selectmemberByEmail(email);
	}
	
	@Override
	public int insertMember(Map<String, Object> memberAuthMap, Member member) {
		int result = memberDao.insertMember(member);
		log.debug("result insertMember = {}", result);
		
		//insert member auth
		result = insertMemberAuth(memberAuthMap);
		
		return result;
	}
	
	@Override
	public int insertSeller(Map<String, Object> memberAuthMap, Seller seller) {
		int result = insertMember(memberAuthMap, seller);
		result = insertSellerInfo(seller.getSellerInfo());
		result = insertSellerInfoAttachment(seller.getAttachment());
		return result;
	}
	
	@Override
	public int insertSellerInfoAttachment(SellerInfoAttachment attachment) {
		return memberDao.insertSellerInfoAttachment(attachment);
	}
	
	@Override
	public int insertSellerInfo(SellerInfo sellerInfo) {
		return memberDao.insertSellerInfo(sellerInfo);
	}

	@Override
	public int insertMemberAuth(Map<String, Object> memberAuthMap) {
		return memberDao.insertMemberAuth(memberAuthMap);
	}
	
	@Override
	public int insertEmailIdentify(Map<String, Object> map) {
		return memberDao.insertEmailIdentify(map);
	}
	
	@Override
	public String getEmailKey(String email) {
		return memberDao.getEmailKey(email);
	}
	
	@Override
	public Seller selectSeller(String memberId) {
		return memberDao.selectSeller(memberId);
	}
	//------------------수진 끝
	
	//------------------수아 시작
	
	@Override
	public Member findMemberId(Map<String, Object> map) {
		return memberDao.findMemberId(map);
	}
	
	@Override
	public int updateTempPw(Map<String, Object> map) {
		return memberDao.updateTempPw(map);
	}
	
	
	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	//------------------수아 끝
}
