package com.kh.monong.inquire.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.monong.inquire.model.dto.Inquire;

@Mapper
public interface InquireDao {

	@Select("select count(*) from inquire where member_id in(select member_id from member_authority where auth = #{auth})")
	public int getTotalInquireContent(Map<String, Object> param);

	public List<Inquire> selectInquireListByMemberType(Map<String, Object> param);

}
