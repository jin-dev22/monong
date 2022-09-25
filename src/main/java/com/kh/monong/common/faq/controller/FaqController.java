package com.kh.monong.common.faq.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.monong.common.MonongUtils;
import com.kh.monong.common.faq.model.dto.Faq;
import com.kh.monong.common.faq.model.service.FaqService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/common")
public class FaqController {
	
	@Autowired
	private FaqService faqService;
	
	/**
	 * 브랜드스토리
	 */
	@GetMapping("/brandStory.do")
	public void brandStory() {}
	
	/**
	 * FAQ
	 */
	@GetMapping("/faqList.do")
	public void faqList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		List<Faq> faqList = faqService.getFaqList(param);
		
		int totalContent = faqService.getTotalContent();
		String url = request.getRequestURI();
		String pagebar = MonongUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("faqList", faqList);
		model.addAttribute("pagebar", pagebar);
	};
	
	@GetMapping("/searchLikeKeyword.do")
	public ResponseEntity<?> searchLikeKeyword(String keyword){
		List<Faq> searchFaqList = faqService.searchLikeKeyword(keyword);
		log.debug("searchFaqList", searchFaqList);
		return ResponseEntity.ok().body(searchFaqList);
	}
	
	@GetMapping("/searchType.do")
	public ResponseEntity<?> searchType(
			@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request, 
			@RequestParam String type){
		List<Faq> searchFaqList = null;
		if("total".equals(type)) {
			Map<String, Integer> param = new HashMap<>();
			int limit = 10;
			param.put("cPage", cPage);
			param.put("limit", limit);
			searchFaqList = faqService.getFaqList(param);
			
			int totalContent = faqService.getTotalContent();
			String url = request.getRequestURI();
			String pagebar = MonongUtils.getPagebar(cPage, limit, totalContent, url);
			
			Map<Object, Object> faqMap = new HashMap<>();
			faqMap.put("searchFaqList", searchFaqList);
			faqMap.put("pagebar", pagebar);
			
			return ResponseEntity.ok().body(faqMap);
		}
		else {
			searchFaqList = faqService.searchType(type);
		}
		return ResponseEntity.ok().body(searchFaqList);
	}
}
