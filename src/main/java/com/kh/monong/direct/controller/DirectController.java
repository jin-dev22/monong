package com.kh.monong.direct.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.monong.direct.model.service.DirectService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/direct")
@Slf4j
public class DirectController {

	@Autowired
	private DirectService directService;
	
	//----------------- 재경 시작
	
	
	//----------------- 재경 끝
	//----------------- 민지 시작
	//----------------- 민지 끝
}
