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
	public String directProductList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
//		// 1. content영역
//		Map<String, Integer> param = new HashMap<>();
//		int limit = 10;
//		param.put("cPage", cPage);
//		param.put("limit", limit);
//		List<directProduct> list = directService.selectdirectProductList(param);
//		log.debug("list = {}", list);
//		model.addAttribute("list", list);
//		
//		// 2. pagebar영역
//		int totalContent = directService.getTotalContent();
//		log.debug("totalContent = {}", totalContent);
//		String url = request.getRequestURI(); // /spring/direct/directProductList.do
//		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
//		model.addAttribute("pagebar", pagebar);
//	}
//	
//	@Autowired
//	ServletContext application;
//	
//	@Autowired
//	ResourceLoader resourceLoader;
//	
//	@GetMapping("/directProductAdd.do")
//	public String directProductAdd(
//			DirectProduct directProduct,
//			@RequestParam(name = "upFile") List<MultipartFile> upFileList,
//			RedirectAttributes redirectAttr) 
//					throws IllegalStateException, IOException {
//		
//		
//		for(MultipartFile upFile : upFileList) {			
////			log.debug("upFile = {}", upFile);
////			log.debug("upFile#name = {}", upFile.getName()); // upFile
////			log.debug("upFile#name = {}", upFile.getOriginalFilename());
////			log.debug("upFile#size = {}", upFile.getSize());
//			
//			if(!upFile.isEmpty()) {				
//				// a. 서버컴퓨터에 저장
//				String saveDirectory = application.getRealPath("/resources/upload/board");
//				String renamedFilename = HelloSpringUtils.getRenamedFilename(upFile.getOriginalFilename()); 
//				File destFile = new File(saveDirectory, renamedFilename);
//				upFile.transferTo(destFile); // 해당경로에 파일을 저장
//				
//				// b. DB저장을 위해 Attachment객체 생성
//				DirectProductAttachment attach = new DirectProductAttachment(upFile.getOriginalFilename(), renamedFilename);
//				directProduct.add(attach);
//			}
//		}
//		
//		log.debug("directProduct = {}", directProduct);
//		
//		// db저장
//		int result = directService.insertBoard(directProduct);
//		
//		redirectAttr.addFlashAttribute("msg", "상품을 성공적으로 저장했습니다.");
		
		return "redirect:/direct/directProductList.do";
	}
	
	//----------------- 재경 끝
	//----------------- 민지 시작
	@GetMapping("/directProductDetail.do")
	public String directProductDetail() {
		return "direct/directProductDetail";
	}
	//----------------- 민지 끝
}