package com.kh.monong.security.model.dao;

import com.kh.monong.member.model.dto.Member;

public interface MemberSecurityDao {

	Member loadUserByUsername(String username);

}
