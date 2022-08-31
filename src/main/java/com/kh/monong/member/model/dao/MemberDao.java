package com.kh.monong.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.monong.member.model.dto.MemberEntity;

@Mapper
public interface MemberDao {

	@Select("select * from member where member_id = 'test'")
	MemberEntity selectTest();

}
