package com.kh.monong.common.faq.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.monong.common.faq.model.dto.Faq;

public interface FaqDao {
	
	@Select("select * from faq order by faq_no")
	List<Faq> getFaqList(RowBounds rowBounds);
	
	@Select("select * from faq where faq_title like '%' || #{keyword} || '%' or faq_content like '%' || #{keyword} || '%'")
	List<Faq> searchLikeKeyword(String keyword);
	
	@Select("select count(*) from faq")
	int getTotalContent();
	
	@Select("select * from faq order by faq_no")
	List<Faq> getFaqAllList();
	
	@Select("select * from faq where faq_type = #{type}")
	List<Faq> searchType(String type);

	
	
	
}
