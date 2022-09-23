package com.kh.monong.notice.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.monong.notice.model.dao.NotificationDao;
import com.kh.monong.notice.model.dto.MemberNotification;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class NotificationServiceImpl implements NotificationService{

	@Autowired
	private NotificationDao notificationDao;
	@Override
	public List<MemberNotification> selectNotificationListByMemberId(String memberId) {
		return notificationDao.selectNotificationListByMemberId(memberId);
	}
}
