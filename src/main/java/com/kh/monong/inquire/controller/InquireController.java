package com.kh.monong.inquire.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/inquire")
public class InquireController {

	@GetMapping("/inquireAdmin.do")
	public void inquireAdmin() {};
}
