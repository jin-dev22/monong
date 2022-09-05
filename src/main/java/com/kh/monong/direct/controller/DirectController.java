package com.kh.monong.direct.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.common.HelloSpringUtils;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;
import com.kh.monong.direct.model.service.DirectService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/direct")
@Slf4j
public class DirectController {

	@Autowired
	private DirectService directService;
	
	//----------------- 재경 시작
	@GetMapping("/directProductList.do")
	public void directProductList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		// 1. content영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		List<DirectProduct> list = directService.selectDirectProductList(param);
		log.debug("list = {}", list);
		model.addAttribute("list", list);
		
		// 2. pagebar영역
		int totalContent = directService.getDirectProductTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI(); // /monong/direct/directProductList.do
		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
	//----------------- 재경 끝
	//----------------- 민지 시작
	@GetMapping("/directProductDetail")
	public String directProductDetail() {
		return "direct/directProductDetail.do";
	}
	//----------------- 민지 끝
}