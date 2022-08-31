package com.kh.monong.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.monong.member.model.dto.MemberEntity;
import com.kh.monong.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/test")
	public String devList(Model model) {
		MemberEntity tester = memberService.selectTest();
		log.debug("tester = {}", tester);
		log.debug("controller");
		model.addAttribute("tester", tester);
		return null;
	}
}
