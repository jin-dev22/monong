package com.kh.monong.member.model.dto;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.kh.monong.common.enums.YN;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true) //부모요소에서 받은거까지
public class Member extends MemberEntity implements UserDetails {

	/**
	 * SimpleGrantedAuthority
	 * - 문자열로 권한을 관리
	 * - "ROLE_USER" -> new SimpleGrantedAuthority("ROLE_USER")
	 */
	private List<SimpleGrantedAuthority> authorities;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return memberId;
	}
	
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return memberPassword;
	}

	//밑에 세가지 무조건 true 반환하도록
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return memberDel.equals(YN.N);
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return memberDel.equals(YN.N);
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return memberDel.equals(YN.N);
	}

	
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return memberDel.equals(YN.N);
	}

}
