package com.kh.monong.notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.monong.notice.model.dto.MemberNotification;
import com.kh.monong.notice.model.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/notification")
@Slf4j
public class NotificationController {
	@Autowired
	private NotificationService notificationService;
	
	@GetMapping("/memberNotificationList.do")
	public void memberNotificationList(Authentication authentication, Model model){
		String memberId = authentication.getName();
		List<MemberNotification> notification = notificationService.selectNotificationListByMemberId(memberId);
		model.addAttribute("notification", notification);
	}
}
