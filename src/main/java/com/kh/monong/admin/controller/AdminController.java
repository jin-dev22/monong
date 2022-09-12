package com.kh.monong.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.common.HelloSpringUtils;
import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.Seller;
import com.kh.monong.member.model.dto.SellerInfoAttachment;
import com.kh.monong.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/memberList.do")
	public void memberList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Integer> param = new HashMap<>();
		int limit = 5;
		param.put("cPage", cPage);
		param.put("limit", limit);
		int totalContent = memberService.getTotalMember();
		List<Member> memberList = memberService.findAllMember(param);
		log.debug("list={}", memberList);
				
		String url = request.getRequestURI(); 
		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute(memberList);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/sellerList.do")
	public void sellerList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Integer> param = new HashMap<>();
		int limit = 5;
		param.put("cPage", cPage);
		param.put("limit", limit);
		int totalContent = memberService.getTotalSeller();
		List<Seller> sellerList = memberService.findAllSeller(param);
		log.debug("list={}", sellerList);
		
		String totalWaitSeller = Integer.toString(memberService.getTotalWaitSeller());
		log.debug("totalWaitSeller={}", totalWaitSeller);

		String url = request.getRequestURI(); 
		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("totalWaitSeller",totalWaitSeller);
		model.addAttribute("sellerList",sellerList);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/sellerWaitList.do")
	public void sellerWaitList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		List<Seller> sellerWaitList = memberService.findWaitSeller(param);
		int totalContent = memberService.getTotalWaitSeller();
		
		log.debug("sellerWaitList={}", sellerWaitList);
		String totalWaitSeller = Integer.toString(memberService.getTotalWaitSeller());
		log.debug("totalWaitSeller={}", totalWaitSeller);
		String totalSellerEnroll = Integer.toString(memberService.getTotalSellerEnrollByMonth());
		String url = request.getRequestURI(); 
		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("totalSellerEnroll",totalSellerEnroll);
		model.addAttribute("totalWaitSeller",totalWaitSeller);
		model.addAttribute("sellerWaitList",sellerWaitList);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping(path= "/fileDownload.do", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public Resource fileDownload(@RequestParam int no, HttpServletResponse response) throws IOException {
		SellerInfoAttachment attach = memberService.selectSellerAttach(no);
		log.debug("attach= {}", attach);
		String saveDirectory = application.getRealPath("/resources/upload/sellerRegFiles");
		File downFile = new File(saveDirectory, attach.getRenamedFilename());
		String location = "file:"+downFile;
		Resource resource = resourceLoader.getResource(location);
		
		response.setContentType("application/octet-stream; charset=utf-8");
		String filename = new String(attach.getOriginalFilename().getBytes("utf-8"), "iso-8859-1");
		response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" +filename+ "\"");
		
		return resource;
	}
	
	@PostMapping("/updateSellerStatus.do")
	public String updateSellerStatus(@RequestParam String id,RedirectAttributes redirectAttr) {
		int result = memberService.updateSellerStatus(id);
		redirectAttr.addFlashAttribute("msg", "승인 처리가 완료되었습니다.");
		return "redirect:/admin/sellerWaitList.do";
	}
}
