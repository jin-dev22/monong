package com.kh.security.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.SellerInfo;

public interface MemberSecurityDao {

	Member loadUserByUsername(String username);

	@Select("select * from seller_info where member_id = #{memberId}")
	SellerInfo selectSellerInfo(String memberId);

	List<SimpleGrantedAuthority> selectAuthorities(String memberId);
}
