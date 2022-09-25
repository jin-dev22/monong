package com.kh.monong.notice.model.service;

import java.util.List;
import java.util.Map;

import com.kh.monong.notice.model.dto.MemberNotification;

public interface NotificationService {
//---------------------------------------------수진시작
	int insertNotification(MemberNotification notice);
	
	int notificationHasRead(long notiNo);
	
	List<MemberNotification> selectNotificationListByMemberId(Map<String, Object> param);
	
	int getNoticeCount(String memberId);

	int getNewNoticeCount(String memberId);
//---------------------------------------------수진끝
}
