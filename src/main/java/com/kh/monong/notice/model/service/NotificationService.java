package com.kh.monong.notice.model.service;

import java.util.List;

import com.kh.monong.notice.model.dto.MemberNotification;

public interface NotificationService {
//---------------------------------------------수진시작
	int insertNotification(MemberNotification notice);
//---------------------------------------------수진끝
	
//---------------------------------------------선아시작
	List<MemberNotification> selectNotificationListByMemberId(String memberId);
//---------------------------------------------선아끝

}
