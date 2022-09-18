package com.kh.monong.inquire.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.monong.inquire.model.dto.Inquire;
import com.kh.monong.inquire.model.dto.InquireAnswer;

@Mapper
public interface InquireDao {

	@Select("select count(*) from inquire where member_id in(select member_id from member_authority where auth = #{auth})")
	public int getTotalInquireContent(Map<String, Object> param);

	public List<Inquire> selectInquireListByMemberType(Map<String, Object> param);

	@Insert("insert into inquire_answer values(seq_inquire_a_no.nextval,#{inquireNo}, #{inquireAContent},  default)")
	public int insertInquireAnswer(InquireAnswer inqAnswer);

	@Update("update inquire set has_answer = 'Y' where inquire_no = #{inquireNo}")
	public int updateInquireHasAnswered(String inquireNo);

	@Insert("insert into inquire values(seq_inquire_no.nextval, #{memberId}, #{inquireTitle}, #{inquireContent}, default, default)")
	public int insertInquire(Inquire inquire);

}
