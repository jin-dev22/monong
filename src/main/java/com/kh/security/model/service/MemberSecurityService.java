package com.kh.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.monong.member.model.dto.Member;
import com.kh.security.model.dao.MemberSecurityDao;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class MemberSecurityService implements UserDetailsService {

	@Autowired
	MemberSecurityDao memberSecurityDao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Member member = memberSecurityDao.loadUserByUsername(username);
		if(member == null)
			throw new UsernameNotFoundException(username);
		
		log.info("member = {}", member);
		return member;
	}

}
