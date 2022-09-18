package com.kh.monong.direct.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.monong.direct.model.dao.DirectDao;
import com.kh.monong.direct.model.dto.Cart;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class DirectServiceImpl implements DirectService {

	@Autowired
	private DirectDao directDao;
	//----------------- 재경 시작
	@Override
	public List<DirectProduct> selectDirectProductList(Map<String, Integer> param) {
		// mybatis에서 제공하는 페이징처리객체 RowBounds
		// offset limit
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return directDao.selectDirectProductList(rowBounds);
	}
	
	@Override
	public List<DirectProductAttachment> selectDirectProductAttachmentList() {
		return directDao.selectDirectProductAttachmentList();
	}
	@Override
	public int getTotalContent() {
		return directDao.getTotalContent();
	}
	
	// 상품 등록
	@Override
	public int insertDirectProduct(DirectProduct directProduct) {
		// insert directProduct
		int result = directDao.insertDirectProduct(directProduct);
		log.debug("directProduct#no = {}", directProduct.getDProductNo());
		
		// insert attachment * 4
		List<DirectProductAttachment> attachments = directProduct.getDirectProductAttachments();
		if(!attachments.isEmpty()) {
			for(DirectProductAttachment attach : attachments) {
				attach.setDProductNo(directProduct.getDProductNo());
				result = insertDirectProductAttachment(attach);
			}
		}
		return result;
	}
	
	@Override
	public int insertDirectProductAttachment(DirectProductAttachment attach) {
		return directDao.insertDirectProductAttachment(attach);
	}
	
	
	
	//----------------- 재경 끝
	//----------------- 민지 시작
	@Override
	public DirectProduct selectOneDirectProduct(String dProductNo) {
		return directDao.selectOneDirectProductCollection(dProductNo);
	}
	
	@Override
	public Cart checkCartDuplicate(Map<String, Object> cart) {
		return directDao.checkCartDuplicate(cart);
	}
	//----------------- 민지 끝
}
	
	