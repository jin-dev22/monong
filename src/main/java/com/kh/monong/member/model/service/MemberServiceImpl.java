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
	
	@Override
	public MemberEntity selectTest() {
		log.debug("service");
		return memberDao.selectTest();
	}
}
