package com.kh.monong.common.faq.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.common.faq.model.dao.FaqDao;
import com.kh.monong.common.faq.model.dto.Faq;

@Service
public class FaqServiceImpl implements FaqService {
	
	@Autowired
	private FaqDao faqDao;
	
	@Override
	public List<Faq> getFaqList(Map<String, Integer> param) {
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return faqDao.getFaqList(rowBounds);
	}
	
	@Override
	public List<Faq> searchLikeKeyword(String keyword) {
		return faqDao.searchLikeKeyword(keyword);
	}
	
	@Override
	public int getTotalContent() {
		return faqDao.getTotalContent();
	}
	
	@Override
	public List<Faq> getFaqAllList() {
		return faqDao.getFaqAllList();
	}
	
	@Override
	public List<Faq> searchType(String type) {
		return faqDao.searchType(type);
	}
	
}
