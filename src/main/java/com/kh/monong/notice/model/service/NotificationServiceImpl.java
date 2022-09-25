package com.kh.monong.notice.model.service;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

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
	
	@Override
	public int notificationHasRead(long notiNo) {
		return notificationDao.notificationHasRead(notiNo);
	}
	
	@Override
	public int getNoticeCount(String memberId) {
		return notificationDao.getNoticeCount(memberId);
	}
	
	@Override
	public int getNewNoticeCount(String memberId) {
		return notificationDao.getNewNoticeCount(memberId);
	};
	
	@Override
	public List<MemberNotification> selectNotificationListByMemberId(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		String memberId = (String) param.get("memberId");
		return notificationDao.selectNotificationListByMemberId(memberId, rowBounds);
	}
	
	//---------------------------------------------수진끝

}
