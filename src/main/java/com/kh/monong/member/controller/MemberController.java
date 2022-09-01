package com.kh.monong.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;
	//-------------수진 시작
	@GetMapping("/memberEnroll")
	public String memberEnroll() {
		return "member/memberEnroll";
	}
	
	
	//----------------------수진 끝
	//----------------------수아 시작
	//----------------------수아 끝
}
