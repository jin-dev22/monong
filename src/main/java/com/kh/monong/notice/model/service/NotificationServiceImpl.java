package com.kh.monong.notice.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

import com.kh.monong.notice.model.dao.NotificationDao;
import com.kh.monong.notice.model.dto.MemberNotification;

import org.springframework.transaction.annotation.Transactional;


import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class NotificationServiceImpl implements NotificationService{

	@Autowired
	NotificationDao notificationDao;
	//---------------------------------------------수진시작
	
	@Override
	public int insertNotification(MemberNotification notice) {
		return notificationDao.insertNotification(notice);
	}
	//---------------------------------------------수진끝

	//---------------------------------------------선아시작
	@Override
	public List<MemberNotification> selectNotificationListByMemberId(String memberId) {
		return notificationDao.selectNotificationListByMemberId(memberId);
	}
	//---------------------------------------------선아끝

}
