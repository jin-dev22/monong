package com.kh.monong.notice.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.monong.notice.model.dto.MemberNotification;
import com.kh.monong.notice.model.service.NotificationService;
import com.kh.monong.subscribe.model.dto.SubscriptionWeekVegs;
import com.kh.monong.subscribe.model.service.SubscribeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/notification")
@Slf4j
public class NotificationController {
	@Autowired
	private NotificationService notificationService;
	@Autowired
	SubscribeService subscribeService;
	
	@GetMapping("/memberNotificationList.do")
	public void memberNotificationList(Authentication authentication, Model model){
		String memberId = authentication.getName();
		List<MemberNotification> notification = notificationService.selectNotificationListByMemberId(memberId);
		model.addAttribute("notification", notification);
	}
	
	//---------------------------------- 선아 시작
	/**
	 * 주간채소 팝업
	 */
	@GetMapping("/popup/{weekCriterion}.do")
	public String getWeekVegsNotice(
			@PathVariable String weekCriterion,
			Model model, HttpServletRequest request) {
		SubscriptionWeekVegs noticeWeekVegs = subscribeService.getWeekVegsNotice(weekCriterion);
		model.addAttribute("noticeWeekVegs", noticeWeekVegs);
		return "/admin/popup";
	}
	//---------------------------------- 선아 끝
}
