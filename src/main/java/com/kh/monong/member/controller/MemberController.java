package com.kh.monong.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.monong.member.model.dto.MemberEntity;
import com.kh.monong.member.model.service.MemberService;
import com.kh.monong.security.model.service.MemberSecurityService;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberSecurityService memberSecurityService;

	//-------------수진 시작
	@RequestMapping("/test")
	public String devList(Model model) {
		MemberEntity tester = memberService.selectTest();
		log.debug("tester = {}", tester);
		log.debug("controller");
		model.addAttribute("tester", tester);
		return null;
	}
	
	//----------------------수진 끝
	//----------------------수아 시작
	@GetMapping("/memberLogin.do")
	public void memberLogin() {
		
	}
	

	//----------------------수아 끝
}
