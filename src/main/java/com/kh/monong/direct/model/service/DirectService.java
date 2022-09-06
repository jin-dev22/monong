package com.kh.monong.direct.model.service;

import java.util.List;
import java.util.Map;

import com.kh.monong.direct.model.dto.DirectProduct;

public interface DirectService {
	//----------------- 재경 시작
	List<DirectProduct> selectDirectProductList(Map<String, Integer> param);

	int getTotalContent();
	//----------------- 재경 끝
	//----------------- 민지 시작


	DirectProduct selectOneDirectProduct(String dProductNo);

	}
//----------------- 민지 끝