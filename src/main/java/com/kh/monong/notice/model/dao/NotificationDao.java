package com.kh.monong.notice.model.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.kh.monong.notice.model.dto.MemberNotification;

@Mapper
public interface NotificationDao {

	int insertNotification(MemberNotification notice);

}
