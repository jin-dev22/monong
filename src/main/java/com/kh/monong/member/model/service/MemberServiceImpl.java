package com.kh.monong.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.member.model.dao.MemberDao;
import com.kh.monong.member.model.dto.MemberEntity;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	//------------------수진 시작
	@Override
	public MemberEntity selectTest() {
		log.debug("service");
		return memberDao.selectTest();
	}
	//------------------수진 끝
	
	//------------------수아 시작
	//------------------수아 끝
}
