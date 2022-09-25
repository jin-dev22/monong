package com.kh.monong.notice.model.service;

import java.util.List;

import com.kh.monong.notice.model.dto.MemberNotification;

public interface NotificationService {
//---------------------------------------------수진시작
	int insertNotification(MemberNotification notice);
	
	int notificationHasRead(long notiNo);
	
	List<MemberNotification> selectNotificationListByMemberId(String memberId);
//---------------------------------------------수진끝
	

}
