package com.kh.monong.notice.model.service;

import java.util.List;

import com.kh.monong.notice.model.dto.MemberNotification;

public interface NotificationService {

	List<MemberNotification> selectNotificationListByMemberId(String memberId);

}
