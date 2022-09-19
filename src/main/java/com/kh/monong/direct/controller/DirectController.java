package com.kh.monong.direct.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.monong.common.HelloSpringUtils;
import com.kh.monong.direct.model.dto.Cart;
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
	
	// 상품 상세 불러오기
	@GetMapping("/directProductDetail.do")
	public void directProductDetail(@RequestParam String dProductNo, Model model) {
		DirectProduct directProduct = directService.selectOneDirectProduct(dProductNo);
		
		log.debug("directProduct = {}", directProduct);
		model.addAttribute("directProduct", directProduct);
	}
	
	// 장바구니 페이지
	@GetMapping("/cart.do")
	public void cart() {
		
	}
	
	// 장바구니 중복 검사
	@GetMapping("/checkCartDuplicate.do")
	public String checkCartDuplicate(@RequestParam(value="optionNoList[]") List<String> optionNoList, @RequestParam String memberId, Model model) {
		log.debug("optionNoList = {}", optionNoList);
		log.debug("memberId = {}", memberId);
		
		List<Cart> cartList = new ArrayList<>();
		Map<String, Object> cart = new HashMap<>();
		
		for(String optionNo : optionNoList) {
			cart.put("optionNo", optionNo);
			cart.put("memberId", memberId);
			log.debug("cart = {}", cart);
			
			Cart oneCart = directService.checkCartDuplicate(cart);
			log.debug("oneCart = {}", oneCart);
			
			if(oneCart != null)
				cartList.add(oneCart);
		}
		log.debug("cartList = {}", cartList);
		
		model.addAttribute("cartList", cartList);
			
		return "jsonView";
	}
	
	// 장바구니 추가
	@ResponseBody
	@PostMapping("/addCart.do")
	public void addCart(@RequestBody List<Map<String,Object>> cartList, Model model) {
		log.debug("cartList = {}", cartList);

		for(Map<String, Object> addList : cartList) {
			int checkCount = directService.checkCountCartDuplicate(addList);
			log.debug("checkCount = {}", checkCount);
			if(checkCount > 0) {
				int updateResult = directService.updateCart(addList);
				log.debug("update = {}", updateResult);
			}
			else {
				int insertResult = directService.insertCart(addList);
				log.debug("insert = {}", insertResult);
			}
						
		}
	}
	
	@GetMapping("/directOrder.do")
	public void directOrder() {}
	
	@PostMapping("/directOrder.do")
	public void directOrder(@RequestParam(value="dOptionNo") List<String> dOptionNo, @RequestParam(value="productCount") List<Integer> productCount, @RequestParam(value="memberId") List<String> memberId, Model model) {
		log.debug("dOptionNo = {}", dOptionNo);
		log.debug("productCount = {}", productCount);
		log.debug("memberId = {}", memberId);
		
		List<DirectProduct> orderList = new ArrayList<>();
		
		Map<String, Object> param = new HashMap<>();
		for(int i = 0; i < dOptionNo.size(); i++) {
			param.put("dOptionNo", dOptionNo.get(i));
			param.put("productCount", productCount.get(i));
			param.put("memberId", memberId.get(i));
			log.debug("param = {}", param);
			orderList.add(directService.buyIt(param));
		}
		log.debug("orderList = {}", orderList);
		
		model.addAttribute("orderList", orderList);
		
	}
	//----------------- 민지 끝
}