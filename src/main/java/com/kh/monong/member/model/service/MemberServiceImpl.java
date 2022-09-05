package com.kh.monong.member.model.service;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.member.model.dao.MemberDao;
import com.kh.monong.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;

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
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
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
