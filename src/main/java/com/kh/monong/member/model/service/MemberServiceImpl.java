package com.kh.monong.member.model.service;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.monong.member.model.dao.MemberDao;
import com.kh.monong.member.model.dto.Member;

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
	public int insertMemberAuth(Map<String, Object> memberAuthMap) {
		return memberDao.insertMemberAuth(memberAuthMap);
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
	//------------------수아 끝
}
