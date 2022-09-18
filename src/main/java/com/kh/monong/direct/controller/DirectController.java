package com.kh.monong.direct.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.common.HelloSpringUtils;
import com.kh.monong.direct.model.dto.DirectOrder;
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
	// 생명주기가 가장 긴 scope객체 ServletContext : 스프링빈을 관리하는 servlet-context와 무관하다.
		@Autowired
		ServletContext application;
				
		@Autowired
		ResourceLoader resourceLoader;
		
		@Autowired
	    private ServletContext servletContext;
		
			
		// 직거래 상품 리스트 출력
		@GetMapping("/directProductList.do")
		public void directProductList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
			// 1. content영역
			Map<String, Integer> param = new HashMap<>();
			int limit = 10;
			param.put("cPage", cPage);
			param.put("limit", limit);
			List<DirectProduct> list = directService.selectDirectProductList(param);
			List<DirectProductAttachment> attachList = directService.selectDirectProductAttachmentList();
			log.debug("list = {}", list);
			model.addAttribute("list", list);
			log.debug("attachList = {}", attachList);
			model.addAttribute("attachList", attachList);
				
			// 2. pagebar영역
			int totalContent = directService.getTotalContent();
			
			String url = request.getRequestURI(); // /monong/direct/directProductList.do
			String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
			model.addAttribute("pagebar", pagebar);
		}
		
		// 상품 등록
		@GetMapping("/directProductEnroll.do")
		public void directProductEnroll() {
			
		}
		
		
		@PostMapping("/directProductEnroll.do")
		public String directProductEnroll(
				DirectProduct directProduct,
				@RequestParam(name = "upFile") List<MultipartFile> upFileList,
				RedirectAttributes redirectAttr) 
						throws IllegalStateException, IOException {
			
			for(MultipartFile upFile : upFileList){
				if(!upFile.isEmpty()) {
					// a. 서버컴퓨터에 저장
					String saveDirectory = application.getRealPath("/resources/upload/product");
					String renamedFilename = HelloSpringUtils.getRenamedFilename(upFile.getOriginalFilename()); // 20220816_193012345_123.txt
					File destFile = new File(saveDirectory, renamedFilename);
					upFile.transferTo(destFile); // 해당경로에 파일을 저장
					
					// b. DB저장을 위해 Attachment객체 생성
					DirectProductAttachment attach = new DirectProductAttachment(upFile.getOriginalFilename(), renamedFilename);
					directProduct.add(attach);
				}
			}
			
			log.debug("directProduct = {}", directProduct);
			
			// db저장
			int result = directService.insertDirectProduct(directProduct);
			
			redirectAttr.addFlashAttribute("msg", "상품을 성공적으로 등록했습니다.");
			
			return "redirect:/direct/directProductList.do";
		
		}
		
		//----------------- 재경 끝
	//----------------- 민지 시작
	@GetMapping("/directProductDetail.do")
	public void directProductDetail(@RequestParam String dProductNo, Model model) {
		DirectProduct directProduct = directService.selectOneDirectProduct(dProductNo);
		
		log.debug("directProduct = {}", directProduct);
		model.addAttribute("directProduct", directProduct);
	}
	
	@GetMapping("/cart.do")
	public void cart() {
		
	}
	
	@GetMapping("/findCart.do")
	public void findCart(@RequestParam(value="dOptionNo", required=false) List<String> dOptionNo) {
		log.debug("dOptionNo = {}", dOptionNo);
	}
	
	@GetMapping("/directOrder.do")
	public void directOrder(@RequestParam(value="dOptionNo", required=false) List<String> dOptionNo, @RequestParam(value="dOptionCount", required=false) List<Integer> dOptionCount) {
		log.debug("dOptionNo = {}", dOptionNo);
		log.debug("dOptionCount = {}", dOptionCount);
	}
	
	@PostMapping("/directOrder.do")
	public String directOrder(@RequestParam String dOptionNo, @RequestParam String dOptionCount, @ModelAttribute DirectOrder directOrder, RedirectAttributes redirectAttr, Model model) {
		
		
		return "redirect:/member/directOrderList.do";
	}
	//----------------- 민지 끝
}