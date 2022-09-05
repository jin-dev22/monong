package com.kh.monong.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.common.MailUtils;
import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.Seller;
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
	public void selectEnrollType() {		
	}
	
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
		log.debug("result map = {}", map);
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
			
			//회원권한 db입력용 설정.
			Map<String, Object> memberAuthMap = new HashMap<>();
			memberAuthMap.put("memberId", member.getMemberId());
			memberAuthMap.put("memberAuth", "ROLE_MEMBER");
			int result = memberService.insertMember(memberAuthMap, member);
			redirectAttr.addFlashAttribute("msg", "회원 가입이 정상적으로 처리되었습니다.");
			return "redirect:/";
		} catch(Exception e) {
			log.error("회원등록 오류 : " + e.getMessage(), e);
			throw e;
		}
	}
	
	@PostMapping("/sendEmailKey.do")
	public ResponseEntity<?> sendEmailKey(@RequestParam String email){
		Map<String, Object> map = new HashMap<>();
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			String identifyKey = new TempKey().getKey(4,false);
			map.put("identifyKey", identifyKey);
			map.put("memberEmail", email);
			
			sendMail.setSubject("모농모농 회원가입 이메일 인증코드입니다.");
			sendMail.setText("<h1>이메일 인증코드</h1>"
					+ "<br />"+ "인증코드는"
							+ "<br /><strong>"+identifyKey+"</strong>입니다."
							+ "<br />감사합니다!"
								);
			sendMail.setFrom("sooappeal31@gmail.com", "모농모농");
			sendMail.setTo(email);
			sendMail.send();
			//db저장
			int result = memberService.insertEmailIdentify(map);
			log.debug("after db ={}", map.remove("identifyKey"));
			map.put("msg", "입력하신 이메일로 인증코드가 전송되었습니다.");
			
		} catch(Exception e) {
			log.error("이메일 인증코드 전송오류 : " + e.getMessage(), e);
		}
		return ResponseEntity.status(HttpStatus.OK).body(map);
	}
	
	@PostMapping("/checkEmailKey.do")
	public ResponseEntity<?> checkEmailKey(@RequestParam String email, @RequestParam String emailKey){
		Map<String, Object> map = new HashMap<>();
		String key = memberService.getEmailKey(email);
		log.debug("db key ={}", key);
		boolean isIdentified = emailKey.equals(key);
		String msg = isIdentified? "이메일 인증 완료!" : "인증코드가 일치하지 않아요. 다시 확인해주세요.";
		map.put("msg", msg);
		map.put("isIdentified", isIdentified);
		
		return ResponseEntity.status(HttpStatus.OK).body(map);
	}
	
	@GetMapping("/selectSeller/{memberId}")
	public ResponseEntity<?> selectSeller(@PathVariable String memberId){
		Seller seller = memberService.selectSeller(memberId);
		log.debug("seller = {}",seller);
		return ResponseEntity.status(HttpStatus.OK).body(seller);
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
	
	@GetMapping("/memberPwSearchForm.do")
	public void memberPwSearchForm() {
		
	}
	
	@PostMapping("/memberPwSearchForm.do")
	public String memberPwSearchForm(@RequestParam String email, 
								     @RequestParam String name,
									 RedirectAttributes redirectAttr) throws Exception {
		MailUtils sendMail = new MailUtils(mailSender);
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("name", name);
		Member member = memberService.findMemberId(map);
		if(member == null) {
			redirectAttr.addFlashAttribute("msg", "일치하는 회원정보가 없습니다.");
			return "redirect:/member/memberPwSearchForm.do";
		}
		
		try {
		//임시 비밀번호
		String memberKey = new TempKey().getKey(6,false);
		String memberTempPw = bcryptPasswordEncoder.encode(memberKey);	
		map.put("memberTempPw", memberTempPw);
		int result = memberService.updateTempPw(map);
		
		sendMail.setSubject("모농모농 임시 비밀번호 발급");
		sendMail.setText("<h1>임시 비밀번호</h1>"
		+ "<br />"+ member.getMemberName()+"님"
				+ "<br />임시 비밀번호는"
				+ "<br /><strong>"+memberKey+"</strong>입니다."
				+ "<br />반드시 비밀번호 변경을 해주세요"
				+ "<br />감사합니다!"
					);
		sendMail.setFrom("sooappeal31@gmail.com", "모농모농");
		sendMail.setTo(member.getMemberEmail());
		sendMail.send();
		} catch (MessagingException e) {
		e.printStackTrace();
		}
		
		redirectAttr.addFlashAttribute("msg", email+"로 임시 비밀번호가 발급됐습니다. 이메일을 확인해주세요");
		
		return "redirect:/member/memberLogin.do";
		} 
	
	//임시 비밀번호 발급 - 일단 6자리로 해놨습니다
	public class TempKey{
			private boolean lowerCheck;
			private int size;
			
			public String getKey(int size, boolean lowerCheck) {
				this.size = size;
				this.lowerCheck = lowerCheck;
				return init();
			}
			
			private String init() {
				Random ran = new Random();
				StringBuffer sb = new StringBuffer();
				int num  = 0;
				do {
					num = ran.nextInt(75) + 48;
					if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
						sb.append((char) num);
					} else {
						continue;
					}
				} while (sb.length() < size);
				if (lowerCheck) {
					return sb.toString().toLowerCase();
				}
				return sb.toString();
			}
		}
	

	
	//----------------------수아 끝
}
