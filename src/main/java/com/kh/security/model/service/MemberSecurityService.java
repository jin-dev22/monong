package com.kh.security.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.Seller;
import com.kh.monong.member.model.service.MemberService;
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

		if(member.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_SELLER"))) {
			Seller seller = Seller.builder()
					.memberId(member.getMemberId())
					.memberName(member.getMemberName())
					.memberPassword(member.getMemberPassword())
					.memberEmail(member.getMemberEmail())
					.memberAddress(member.getMemberAddress())
					.memberAddressEx(member.getMemberAddressEx())
					.memberPhone(member.getMemberPhone())
					.memberBirthday(member.getMemberBirthday())
					.memberDel(member.getMemberDel())
					.memberEnrollDate(member.getMemberEnrollDate())
					.memberQuitDate(member.getMemberQuitDate())
					.memberIdentified(member.getMemberIdentified())
					.authorities(selectSellerAuthorities(member.getMemberId()))
					.sellerInfo(memberSecurityDao.selectSellerInfo(member.getMemberId()))
					.build();
			log.debug("seller = {}", seller);
			return seller;
		}
		
		log.info("member = {}", member);
		return member;
	}

	private List<SimpleGrantedAuthority> selectSellerAuthorities(String memberId) {
		return memberSecurityDao.selectAuthorities(memberId);
	}

}
