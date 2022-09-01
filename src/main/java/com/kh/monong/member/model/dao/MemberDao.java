package com.kh.monong.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.monong.member.model.dto.MemberEntity;

@Mapper
public interface MemberDao {

	//------------------------수진 시작
	@Select("select * from member where member_id = 'test'")
	MemberEntity selectTest();

	//------------------------수진 시작
	
	//------------------------수아 시작
	//------------------------수아 끝
}
