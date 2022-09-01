package com.kh.monong.direct.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.direct.model.dao.DirectDao;

@Service
public class DirectServiceImpl implements DirectService {

	@Autowired
	private DirectDao directDao;
}
