package com.kh.monong.inquire.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.inquire.model.dto.Inquire;
import com.kh.monong.inquire.model.service.InquireService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/inquire")
public class InquireController {

	@Autowired InquireService inquireService;
	
	@GetMapping("/inquireAdmin.do")
	public void inquireAdmin() {};
	
	/**
	 * 회원 -> 관리자 문의
	 * @param inquire
	 * @param redirectAttr
	 * @return
	 */
	@PostMapping("/inquireAdmin.do")
	public String insertInquire(Inquire inquire, RedirectAttributes redirectAttr) {
		log.debug("inquire = {}", inquire);
		int result = inquireService.insertInquire(inquire);
		redirectAttr.addFlashAttribute("msg", "관리자 문의가 등록되었습니다.");
		return "redirect:/inquire/inquireAdmin.do";
	}
}
