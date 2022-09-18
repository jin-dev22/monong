package com.kh.monong.direct.model.service;

import java.util.List;
import java.util.Map;

import com.kh.monong.direct.model.dto.Cart;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;

public interface DirectService {
	//----------------- 재경 시작
	List<DirectProduct> selectDirectProductList(Map<String, Integer> param);

	List<DirectProductAttachment> selectDirectProductAttachmentList();

	int getTotalContent();
	
	// 상품 등록
	public void directProductEnroll(DirectProduct directProduct);
	
	//----------------- 재경 끝
	//----------------- 민지 시작
	DirectProduct selectOneDirectProduct(String dProductNo);

	Cart checkCartDuplicate(Map<String, Object> cart);
	//----------------- 민지 끝

}


