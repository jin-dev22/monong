package com.kh.monong.direct.model.service;

import java.util.List;
import java.util.Map;

import com.kh.monong.direct.model.dto.Cart;
import com.kh.monong.direct.model.dto.DirectOrder;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;
import com.kh.monong.direct.model.dto.DirectProductOption;

public interface DirectService {
	//----------------- 재경 시작
	List<DirectProduct> selectDirectProductList(Map<String, Integer> param);
	
	List<DirectProductAttachment> selectDirectProductAttachmentList(String dProductNo);

	int getTotalContent();
	
	// 상품 등록
	int insertDirectProduct(DirectProduct directProduct);
	
	int insertDirectProductAttachment(DirectProductAttachment attachment);
	
	int insertDirectProductOption(DirectProductOption dopt);
	
	//----------------- 재경 끝
	//----------------- 민지 시작
	DirectProduct selectOneDirectProduct(String dProductNo);
	
	List<Cart> selectCartListByMemberId(String memberId);
	
	Cart checkCartDuplicate(Map<String, Object> cart);
	
	int addCart(Map<String, Object> addList);

	int deleteCartAll(String memberId);
	
	int deleteCartTarget(int cartNo);
	
	int deleteCartChecked(int checked);
	
	int updateCartProductCount(Map<String, Object> param);

	DirectProduct buyIt(Map<String, Object> param);
	
	int insertDirectOrder(DirectOrder directOrder);
		
	int insertMemberDirectOrder(Map<String, Object> param);
	//----------------- 민지 끝

	//----------------- 수진 시작
	List<DirectProduct> adminSelectPordList(Map<String, Object> param);

	List<DirectProductAttachment> selectDirectAttachments(String dProductNo);
	
	int getTotalProdCntByStatus(Map<String, Object> param);
	
	DirectProductAttachment selectOneDPAttachment(int attachNo);
	
	int deleteDPAttachment(int attachNo);
	
	int updateDirectProduct(DirectProduct directProduct);
	
	int insertDPAttachment(DirectProductAttachment attach);
	
	int mergeIntoDOption(DirectProductOption dOpt);
	//----------------- 수진 끝
}


