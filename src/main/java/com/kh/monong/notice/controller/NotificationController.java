package com.kh.monong.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.monong.admin.controller.AdminController;

import lombok.extern.slf4j.Slf4j;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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
	public void memberNotificationList(Authentication authentication, Model model){
		String memberId = authentication.getName();
		List<MemberNotification> notification = notificationService.selectNotificationListByMemberId(memberId);
		model.addAttribute("notification", notification);
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
