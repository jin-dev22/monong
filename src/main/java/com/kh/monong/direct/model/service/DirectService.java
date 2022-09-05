package com.kh.monong.direct.model.service;

import java.util.List;
import java.util.Map;

import com.kh.monong.direct.model.dto.DirectProduct;

public interface DirectService {

	List<DirectProduct> selectDirectProductList();

	DirectProduct selectOneDirectProduct(String dProductNo);

	}


