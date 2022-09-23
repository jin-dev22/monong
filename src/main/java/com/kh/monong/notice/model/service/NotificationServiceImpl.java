package com.kh.monong.notice.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.monong.notice.model.dao.NotificationDao;
import com.kh.monong.notice.model.dto.MemberNotification;

@Service
public class NotificationServiceImpl implements NotificationService{

	@Autowired
	NotificationDao notificationDao;
	
	@Override
	public int insertNotification(MemberNotification notice) {
		return notificationDao.insertNotification(notice);
	}
}
