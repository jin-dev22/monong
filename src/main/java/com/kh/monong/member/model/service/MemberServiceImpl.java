package com.kh.monong.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.member.model.dao.MemberDao;
import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.MemberEntity;

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
		int result = memberDao.insertMember(member);
		log.debug("result insertMember = {}", result);
		
		//insert member auth
		result = insertMemberAuth(member);
		
		return result;
	}

	@Override
	public int insertMemberAuth(Member member) {
		return memberDao.insertMemberAuth(member);
	}
	//------------------수진 끝
	
	//------------------수아 시작
	//------------------수아 끝
}
