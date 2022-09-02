package com.kh.monong.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.MemberEntity;

@Mapper
public interface MemberDao {

	//------------------------수진 시작
	@Select("select * from member where member_id = #{memberId}")
	Member selectOneMember(String memberId);

	@Insert("insert into member values(#{memberId}, #{memberName}, #{memberPassword}, #{memberEmail}, #{memberAddress}, #{memberAddressEx}, #{memberPhone}, #{memberBirthday}, default, default, null)")
	int insertMember(Member member);

	//------------------------수진 시작
	
	//------------------------수아 시작
	//------------------------수아 끝
}
