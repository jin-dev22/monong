package com.kh.monong.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.member.model.dto.Member;
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
	@GetMapping("/memberEnroll")
	public String memberEnroll() {
		return "member/memberEnroll";
	}
	
	@PostMapping("/checkIdDuplicate.do")
	public ResponseEntity<?> checkIdDuplicate3(@RequestParam String memberId) {
		Member member = memberService.selectOneMember(memberId);
		boolean available = member == null;
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("available", available);
		
		return ResponseEntity.status(HttpStatus.OK).body(map);
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		try {
			log.debug("member = {}", member);
			
			// 비밀번호 암호화
			String rawPassword = member.getPassword();
//			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
//			member.setMemberPassword(encodedPassword);
//			log.debug("encodedPassword = {}", encodedPassword);
			
//			int result = memberService.insertMember(member);
			redirectAttr.addFlashAttribute("msg", "회원 가입이 정상적으로 처리되었습니다.");
			return "redirect:/";
		} catch(Exception e) {
			log.error("회원등록 오류 : " + e.getMessage(), e);
			throw e;
		}
	}
	//----------------------수진 끝
	//----------------------수아 시작
	@GetMapping("/memberLogin.do")
	public void memberLogin() {
		
	}
	

	//----------------------수아 끝
}
