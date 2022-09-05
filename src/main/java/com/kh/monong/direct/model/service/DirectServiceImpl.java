package com.kh.monong.direct.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.monong.direct.model.dao.DirectDao;
import com.kh.monong.direct.model.dto.DirectProduct;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class DirectServiceImpl implements DirectService {

	@Autowired
	private DirectDao directDao;
	
	@Override
	public List<DirectProduct> selectDirectProductList() {
		return directDao.selectDirectProductList();
	}
	
	@Override
	public DirectProduct selectOneDirectProduct(String dProductNo) {
		return directDao.selectOneDirectProductCollection(dProductNo);
	}
}
	
	

