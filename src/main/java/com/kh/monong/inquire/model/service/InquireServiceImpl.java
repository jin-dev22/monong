package com.kh.monong.inquire.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.inquire.model.dao.InquireDao;
import com.kh.monong.inquire.model.dto.Inquire;

@Service
public class InquireServiceImpl implements InquireService{

	@Autowired
	InquireDao inquireDao;
	
	@Override
	public int getTotalInqureContent(Map<String, Object> param) {
		return inquireDao.getTotalInquireContent(param);
	}
	
	@Override
	public List<Inquire> selectInquireListByMemberType(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		param.put("rowBounds", rowBounds);
		return inquireDao.selectInquireListByMemberType(param);
	}
}
