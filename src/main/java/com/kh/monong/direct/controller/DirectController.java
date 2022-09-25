package com.kh.monong.direct.controller;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
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

import com.kh.monong.common.MonongUtils;
import com.kh.monong.direct.model.dto.Cart;
import com.kh.monong.direct.model.dto.DOrderStatus;
import com.kh.monong.direct.model.dto.DirectInquire;
import com.kh.monong.direct.model.dto.DirectOrder;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;
import com.kh.monong.direct.model.dto.DirectProductOption;
import com.kh.monong.direct.model.service.DirectService;
import com.kh.monong.notice.model.dto.MemberNotification;
import com.kh.monong.notice.model.dto.MessageType;
import com.kh.monong.notice.model.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/direct")
@Slf4j
public class DirectController {

	@Autowired
	private DirectService directService;
	
	@Autowired 
	NotificationService notificationService;
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
		int limit = 8;
		param.put("cPage", cPage);
		param.put("limit", limit);
		log.debug("param = {}", param);
		List<DirectProduct> list = directService.selectDirectProductList(param);
		log.debug("list = {}", list);
		
		model.addAttribute("list", list);
			
		// 2. pagebar영역
		int totalContent = directService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI(); // /monong/direct/directProductList.do
		String pagebar = MonongUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
		
		log.debug("model = {}", model);
	}
	// 최근 등록순
	@GetMapping("/orderByCreatedAt.do")
	public void orderByCreatedAt(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		// 1. content영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 8;
		param.put("cPage", cPage);
		param.put("limit", limit);
		log.debug("param = {}", param);
		List<DirectProduct> list = directService.orderByCreatedAt(param);
		log.debug("list = {}", list);
		
		model.addAttribute("list", list);
			
		// 2. pagebar영역
		int totalContent = directService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI(); // /monong/direct/directProductList.do
		String pagebar = MonongUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
		
		log.debug("model = {}", model);
	}
	
	// 상품 가격 높은순
	@GetMapping("/orderByPriceDesc.do")
	public void orderByPriceDesc(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
	// 1. content영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 8;
		param.put("cPage", cPage);
		param.put("limit", limit);
		log.debug("param = {}", param);
		List<DirectProduct> list = directService.orderByPriceDesc(param);
		log.debug("list = {}", list);
				
		model.addAttribute("list", list);
					
		// 2. pagebar영역
		int totalContent = directService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI(); // /monong/direct/directProductList.do
		String pagebar = MonongUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
				
		log.debug("model = {}", model);
	}
	
	// 상품 가격 낮은순
	@GetMapping("/orderByPriceAsc.do")
	public void orderByPriceAsc(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
	// 1. content영역
	Map<String, Integer> param = new HashMap<>();
	int limit = 8;
	param.put("cPage", cPage);
	param.put("limit", limit);
	log.debug("param = {}", param);
	List<DirectProduct> list = directService.orderByPriceAsc(param);
	log.debug("list = {}", list);
						
	model.addAttribute("list", list);
							
	// 2. pagebar영역
	int totalContent = directService.getTotalContent();
	log.debug("totalContent = {}", totalContent);
	String url = request.getRequestURI(); // /monong/direct/directProductList.do
	String pagebar = MonongUtils.getPagebar(cPage, limit, totalContent, url);
	model.addAttribute("pagebar", pagebar);
						
	log.debug("model = {}", model);
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
				String renamedFilename = MonongUtils.getRenamedFilename(upFile.getOriginalFilename()); // 20220816_193012345_123.txt
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile); // 해당경로에 파일을 저장
				
				// b. DB저장을 위해 Attachment객체 생성
				DirectProductAttachment attach = new DirectProductAttachment(upFile.getOriginalFilename(), renamedFilename);
				directProduct.add(attach);
			}
		}
		
		log.debug("directProduct = {}", directProduct);
		
		//상품옵션등록
		List<DirectProductOption> options = directProduct.getDirectProductOptions();
		String prodNo = directProduct.getDProductNo();
		log.debug("prodNo={}", prodNo);
		if(options != null && !options.isEmpty()) {
			for(DirectProductOption option : options) {
				option.setDOptionNo(prodNo);
			}
		}
		
		// db저장
		int result = directService.insertDirectProduct(directProduct);
		
		redirectAttr.addFlashAttribute("msg", "상품을 성공적으로 등록했습니다.");
		
		return "redirect:/direct/directProductList.do";
	
	}
	// 리뷰 추천
	@GetMapping("/directReviewRecommended.do")
	public ResponseEntity<?> directReviewRecommended(@RequestParam String dReviewNo, @RequestParam String memberId) {
		log.debug("dReviewNo = {}", dReviewNo);
		log.debug("memberId = {}", memberId);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("dReviewNo", dReviewNo);
		log.debug("param = {}", param);
		
		int dRecommendedYn = directService.getRecommendedYn(param);
		boolean recommended = dRecommendedYn == 1;
		log.debug("recommended = {}", recommended);
		
		return ResponseEntity.ok(recommended);
	}
	
	@PostMapping("/directReviewRecommendAdd.do")
	public ResponseEntity<?> directReviewRecommendAdd(@RequestParam String memberId, @RequestParam String dReviewNo) {
		log.debug("memberId = {}", memberId);
		log.debug("dReviewNo = {}", dReviewNo);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("dReviewNo", dReviewNo);
		int result = directService.updateDirectReviewRecommendAdd(param);
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("/directReviewRecommendCancel.do")
	public ResponseEntity<?> directReviewRecommendCancel(@RequestParam String memberId, @RequestParam String dReviewNo) {
		log.debug("memberId = {}", memberId);
		log.debug("dReviewNo = {}", dReviewNo);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("dReviewNo", dReviewNo);
		int result = directService.updateDirectReviewRecommendCancel(param);
		
		return ResponseEntity.ok(result);
	}
	//----------------- 재경 끝
	
	// 상품 상세 불러오기
	@GetMapping("/directProductDetail.do")
	public void directProductDetail(@RequestParam String dProductNo, Model model, @RequestParam(defaultValue = "1") int cPage,
									HttpServletRequest request, DirectProduct dp, DirectProductOption dpo) {
		// 재경시작
		Map<String, Object> param = new HashMap<>();
		int limit = 5;
		String dOptionName = dpo.getDOptionName();
		param.put("cPage", cPage);
		param.put("limit", limit);
		param.put("dOptionName", dOptionName);
		param.put("dProductNo", dProductNo);
		
		log.debug("dProductNo = {}", dProductNo);
		List<Map<String, Object>> dReviewList = directService.selectDirectProductReviewList(param);
//		int rTotalContent = directService.getTotalDirectReviewByDProductNo(dProductNo);
//		String url = request.getRequestURI(); 
//		String rPagebar = MonongUtils.getPagebar(cPage, limit, rTotalContent, url);
//		model.addAttribute("rPagebar", rPagebar);
		model.addAttribute("dReviewList", dReviewList);
		log.debug("dReviewList = {}", dReviewList);
		
		// 재경 끝
		// 민지 시작
		// 상품 문의
		Map<String, Object> map = new HashMap<>();
		int _limit = 10;
		map.put("cPage", cPage);
		map.put("limit", _limit);
		map.put("dProductNo", dProductNo);
		
		List<DirectInquire> dInquireList = new ArrayList<>();
		
		dInquireList = directService.findInquireAll(map);
		
		int totalContent = directService.getInquireTotalContent(dProductNo);
		
		String url = request.getRequestURI();
		url += "?dProductNo=" + dProductNo;
		String pagebar = MonongUtils.getPagebar(cPage, _limit, totalContent, url);
		
		model.addAttribute("dInquireList", dInquireList);
		model.addAttribute("pagebar", pagebar);
		// 민지 끝
		
		
		DirectProduct directProduct = directService.selectOneDirectProduct(dProductNo);
		
		log.debug("directProduct = {}", directProduct);
		model.addAttribute("directProduct", directProduct);
	}
	
	// 장바구니 조회
	@GetMapping("/cart.do")
	public void cart(Authentication authentication, Model model) {
		// String sessionId = session.getId();
		// log.debug("sessionId = {}", sessionId);
		String memberId = authentication.getName();
		log.debug("memberId = {}", memberId);
		
		List<Cart> cartList = new ArrayList<>();
		if(memberId != null) {
			cartList = directService.selectCartListByMemberId(memberId);
		}
		log.debug("cartList = {}", cartList);
		
		model.addAttribute("cartList", cartList);
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
		int result = 0;
		for(Map<String, Object> addList : cartList) {
			result = directService.addCart(addList);
			log.debug("result = {}", result);
		}
	}
	
	// 장바구니 전체 삭제
	@GetMapping("/deleteCartAll.do")
	public String deleteCartAll(@RequestParam String memberId) {
		log.debug("memberId = {}", memberId);
		
		int result = directService.deleteCartAll(memberId);
		return "jsonView";
	}
	
	// 장바구니 단건 삭제
	@GetMapping("/deleteCartTarget.do")
	public String deleteCartTarget(@RequestParam int cartNo) {
		log.debug("cartNo = {}", cartNo);
		
		int result = directService.deleteCartTarget(cartNo);
		
		return "jsonView";
	}
	
	// 장바구니 선택 삭제
	@GetMapping("/deleteCartChecked.do")
	public String deleteCartChecked(@RequestParam(value="checkedArr[]") List<Integer> checkedArr) {
		log.debug("checkedArr = {}", checkedArr);
		
		for(int checked : checkedArr) {
			int result = directService.deleteCartChecked(checked);
		}
		
		return "jsonView";
	}
	
	// 장바구니 수량 컨트롤러
	@GetMapping("/updateCartProductCount.do")
	public String updateCartProductCount(@RequestParam int cartNo, @RequestParam int productCount) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("cartNo", cartNo);
		param.put("productCount", productCount);
		
		int result = directService.updateCartProductCount(param);
				
		return "jsonView";
	}
	
	
	// 주문 페이지 로드
	@GetMapping("/directOrder.do")
	public void directOrder() {}
	
	// 주문 처리
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
	
	// 결제 처리
	@PostMapping("/directPay.do")
	public String directPay(DirectOrder directOrder, 
						  @RequestParam(value="optionNoList[]") List<String> optionNoList,
						  @RequestParam(value="productNoList[]") List<String> productNoList, 
						  @RequestParam(value="productCountList[]") List<String> productCountList,
						  Model model) {
		log.debug("optionNoList = {}", optionNoList);
		log.debug("productNoList = {}", productNoList);
		log.debug("productCountList = {}", productCountList);
		
		
		directOrder.setDOrderNo(makedirectOrderNo());
		directOrder.setDOrderStatus(DOrderStatus.P);
		
		log.debug("directOrder = {}", directOrder);
		
		int result = directService.insertDirectOrder(directOrder);
		String dOrderNo = directOrder.getDOrderNo();
		
		Map<String, Object> param = new HashMap<>();
		
		for(int i = 0; i < optionNoList.size(); i++) {
			if(dOrderNo != null) {
				param.put("dOrderNo", dOrderNo);
				param.put("dOptionNo", optionNoList.get(i));
				param.put("memberId", directOrder.getMemberId());
				param.put("dProductNo", productNoList.get(i));
				param.put("dOptionCount", productCountList.get(i));
				log.debug("param = {}", param);
				
				result = directService.insertMemberDirectOrder(param);
			}
		}
		//수진코드시작
		for(String no : productNoList) {
			String content = "상품번호 ["+no+"]에 신규주문이 있습니다.";	
			String sellerId = directService.selectSellerIdByProdNo(no);
			MemberNotification notice = MemberNotification.builder()
										.dOrderNo(dOrderNo)
										.memberId(sellerId)
										.notiContent(content)
										.messageType(MessageType.DO_STATUS)
										.build();
			
			result = notificationService.insertNotification(notice);
		}
		//수진코드 끝
		log.debug("dOrderNo = {}", dOrderNo);
		
		model.addAttribute("dOrderNo", dOrderNo);
		return "jsonView";
	}
	
	public String makedirectOrderNo() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmm");
		DecimalFormat df = new DecimalFormat("000");
		
		return "DO" + sdf.format(new Date()) + df.format(Math.random() * 1000);
	}
	
	// 리뷰 점수 띄우기
	@GetMapping("/reviewAvgScore.do")
	public String reviewAvgScore(@RequestParam String dProductNo, Model model) {
		log.debug("dProductNo = {}", dProductNo);
		
		String reviewAvgScore = null; 
				
		reviewAvgScore = directService.selectReviewAvgScoreByProductNo(dProductNo);
		
		if(reviewAvgScore == null) {
			reviewAvgScore = "0.0";
		}
				
		model.addAttribute("reviewAvgScore", reviewAvgScore);
		
		return "jsonView";
	}
	
	// 상품 문의 등록
	@PostMapping("/enrollInquire.do")
	public String enrollInquire(@RequestParam String dProductNo, @RequestParam String memberId, @RequestParam String inquireTitle, @RequestParam String content) {
		log.debug("dProductNo = {}", dProductNo);
		log.debug("memberId = {}", memberId);
		log.debug("inquireTitle = {}", inquireTitle);
		log.debug("content = {}", content);
		
		Map<String, Object> param = new HashMap<>();
		param.put("dProductNo", dProductNo);
		param.put("memberId", memberId);
		param.put("inquireTitle", inquireTitle);
		param.put("content", content);
		
		//수진시작
		String notiContent = "상품["+dProductNo+"]에 문의가 등록되었습니다.";
		String sellerId = directService.selectSellerIdByProdNo(dProductNo);
		MemberNotification notice = MemberNotification.builder()
				.memberId(sellerId)
				.notiContent(notiContent)
				.messageType(MessageType.NEW_D_INQ)
				.build();
		param.put("notice", notice);
		//수진끝
		
		int result = directService.enrollInquire(param);
		
		return "jsonView";
	}
	//----------------- 민지 끝
	
	//----------------- 수진 시작
	@GetMapping("/directProductUpdate.do")
	public void updateProduct(@RequestParam String prodNo, Model model) {
		DirectProduct oldProd = directService.selectOneDirectProduct(prodNo);
		log.debug("oldProd={}", oldProd);
		model.addAttribute("prod",oldProd);
	}
	
	@PostMapping("/directProductUpdate.do")
	public String updateProduct(DirectProduct directProduct, 
			@RequestParam(name="delFileNo", required = false) int[] delFiles,
			@RequestParam(name="upFile", required = false) List<MultipartFile> upFileList) throws Exception {
		log.debug("directProduct={}",directProduct);
		log.debug("upFile ={}",upFileList);
		
		int result = 0;
		String saveDirectory = application.getRealPath("/resources/upload/product");
		//파일삭제
		if(delFiles != null) {
			for(int attachNo : delFiles) {
				DirectProductAttachment attach = directService.selectOneDPAttachment(attachNo);
				File delFile = new File(saveDirectory, attach.getDProductRenamedFilename());
				boolean isDeleted = delFile.delete();
				log.debug("파일삭제? = {}", attach.getDProductOriginalFilename(), isDeleted);
				
				result = directService.deleteDPAttachment(attachNo);
				log.debug("{}attach 행 삭제결과 = {}", attachNo, result);
				
			}
		}
		
		//파일저장
		for(MultipartFile upFile : upFileList) {
			if(!upFile.isEmpty()) {
				//업로드파일 저장
				String renamedFilename = MonongUtils.getRenamedFilename(upFile.getOriginalFilename());
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);
				
				DirectProductAttachment attach = DirectProductAttachment.builder()
												.dProductOriginalFilename(upFile.getOriginalFilename())
												.dProductRenamedFilename(renamedFilename)
												.dProductNo(directProduct.getDProductNo())
												.build();
				log.debug("attach ={}", attach);
				//direct에 첨부파일 설정 
				directProduct.add(attach);
			}
		}
		//상품정보변경
		List<DirectProductOption> options = directProduct.getDirectProductOptions();
		String prodNo = directProduct.getDProductNo();
		log.debug("prodNo={}",prodNo);
		if(options != null && !options.isEmpty()) {
			for(DirectProductOption opt : options) {
				opt.setDProductNo(prodNo);
			}
		}
		result = directService.updateDirectProduct(directProduct);
		
		return "redirect:/direct/directProductUpdate.do?prodNo=" + directProduct.getDProductNo();
	}
	//----------------- 수진 끝
}