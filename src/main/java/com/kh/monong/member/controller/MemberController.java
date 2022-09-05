package com.kh.monong.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.common.MailUtils;
import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.service.MemberService;
import com.kh.security.model.service.MemberSecurityService;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberSecurityService memberSecurityService;
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	//-------------수진 시작
	@GetMapping("/selectEnrollType.do")
	public void selectEnrollType() {}
	
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {
	}
	
	@GetMapping("/sellerEnroll.do")
	public void sellerEnroll() {
	}
	
	@PostMapping("/checkIdDuplicate.do")
	public ResponseEntity<?> checkIdDuplicate(@RequestParam String memberId) {
		Member member = memberService.selectMemberById(memberId);
		boolean available = member == null;
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("available", available);
		
		return ResponseEntity.status(HttpStatus.OK).body(map);
	}
	
	@PostMapping("/checkEmailDuplicate.do")
	public ResponseEntity<?> checkEmailDuplicate(@RequestParam String email){
		Member member = memberService.selectMemberByEmail(email);
		boolean available = member == null;
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberEmail", email);
		map.put("available", available);
		
		return ResponseEntity.status(HttpStatus.OK).body(map);
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		try {
			log.debug("member = {}", member);
			
			// 비밀번호 암호화
			String rawPassword = member.getPassword();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			member.setMemberPassword(encodedPassword);
			log.debug("encodedPassword = {}", encodedPassword);
			
			//회원권한설정
			List<SimpleGrantedAuthority> auths = new ArrayList<>();
			auths.add(new SimpleGrantedAuthority("Member"));
			member.setAuthorities(auths);
			int result = memberService.insertMember(member);
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
	

	@PostMapping("/memberLoginSuccess.do")
	public String memberLoginSuccess(HttpSession session) {
		log.debug("memberLoginSuccess.do 호출!");
		// 로그인 후처리
		String location = "/";
		
		SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
		if(savedRequest != null) {
			location = savedRequest.getRedirectUrl();
		}
		log.debug("location = {}", location);
		return "redirect:" + location;
	}

	@GetMapping("/memberIdSearchForm.do")
	public void memberIdSearchForm() {
		
	}
	@Inject
	private JavaMailSender mailSender;
	
	@PostMapping("/memberIdSearchForm.do")
	public String memberIdSearchForm(@RequestParam String email, 
								 @RequestParam String name,
								 RedirectAttributes redirectAttr) throws Exception {
		MailUtils sendMail = new MailUtils(mailSender);
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("name", name);
		Member member = memberService.findMemberId(map);
		
		if(member == null) {
			redirectAttr.addFlashAttribute("msg", "일치하는 회원정보가 없습니다.");
			return "redirect:/member/memberIdSearchForm.do";
		}
		
		try {
		
			sendMail.setSubject("모농모농 회원 아이디 조회");
			sendMail.setText("<h1>아이디 조회 결과</h1>"
					+ "<br />"+ member.getMemberName()+"님"
							+ "<br />조회하신 아이디는"
							+ "<br /><strong>"+member.getMemberId()+"</strong>입니다."
							+ "<br />감사합니다!"
								);
			sendMail.setFrom("sooappeal31@gmail.com", "모농모농");
			sendMail.setTo(member.getMemberEmail());
			sendMail.send();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		redirectAttr.addFlashAttribute("msg", email+"로 아이디를 보냈습니다. 이메일을 확인해주세요");
		
		return "redirect:/member/memberIdSearchForm.do";
	} 
	

	
	//----------------------수아 끝
}
