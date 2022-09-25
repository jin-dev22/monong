package com.kh.monong.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.monong.admin.controller.AdminController;
import com.kh.monong.common.MonongUtils;

import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.monong.notice.model.dto.MemberNotification;
import com.kh.monong.notice.model.service.NotificationService;
import com.kh.monong.subscribe.model.dto.SubscriptionWeekVegs;
import com.kh.monong.subscribe.model.service.SubscribeService;


@Controller
@RequestMapping("/notification")
@Slf4j
public class NotificationController {
	@Autowired
	private NotificationService notificationService;
	@Autowired
	SubscribeService subscribeService;
	//---------------------------------------------수진시작
	@GetMapping("/memberNotificationList.do")
	public void memberNotificationList(Authentication authentication, 
								@RequestParam(defaultValue = "1") int cPage, 
								Model model, HttpServletRequest request){
		String memberId = authentication.getName();
		
		Map<String, Object> param = new HashMap<>();
		int limit = 5;
		param.put("cPage", cPage);
		param.put("limit", limit);
		param.put("memberId",memberId);
		
		List<MemberNotification> notificationList = notificationService.selectNotificationListByMemberId(param);
		log.debug("notificationList={}",notificationList);
		model.addAttribute("notificationList", notificationList);
		
		int totalContent = notificationService.getNoticeCount(memberId);
		String url = request.getRequestURI();
		String pagebar = MonongUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
	
	@PostMapping("/memberNotificationList.do")
	public ResponseEntity<?> notificationHasRead(@RequestParam long notiNo){
		int result = notificationService.notificationHasRead(notiNo);
		
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
	
	@PostMapping("/newNotice.do")
	public ResponseEntity<?> newNotice(@RequestParam String memberId){
		int count = notificationService.getNewNoticeCount(memberId);
		
		return ResponseEntity.status(HttpStatus.OK).body(count);
	}
	//---------------------------------------------수진끝
	
	//---------------------------------- 선아 시작
	/**
	 * 로드 시 주간채소 팝업
	 */
	@GetMapping("/popup/{weekCriterion}.do")
	public String getWeekVegsNotice(
			@PathVariable String weekCriterion,
			Model model, HttpServletRequest request) {
		SubscriptionWeekVegs noticeWeekVegs = subscribeService.getWeekVegsNotice(weekCriterion);
		model.addAttribute("noticeWeekVegs", noticeWeekVegs);
		return "/admin/popup";
	}
	/**
	 * 배너 클릭 시 주간채소 팝업
	 */
	@GetMapping("/popup/recent.do")
	public String getRecentWeekVegsNotice(
			Model model, HttpServletRequest request) {
		SubscriptionWeekVegs recentNoticeWeekVegs = subscribeService.getRecentWeekVegsNotice();
		model.addAttribute("recentNoticeWeekVegs", recentNoticeWeekVegs);
		return "/admin/popup";
	}
	
	//---------------------------------- 선아 끝
}
