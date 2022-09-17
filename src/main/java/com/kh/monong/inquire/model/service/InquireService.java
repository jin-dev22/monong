package com.kh.monong.inquire.model.service;

import java.util.List;
import java.util.Map;

import com.kh.monong.inquire.model.dto.Inquire;

public interface InquireService {

	List<Inquire> selectInquireListByMemberType(Map<String, Object> param);

	int getTotalInqureContent(Map<String, Object> param);

}
