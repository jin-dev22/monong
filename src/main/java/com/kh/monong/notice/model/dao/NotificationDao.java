package com.kh.monong.notice.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.monong.notice.model.dto.MemberNotification;

@Mapper
public interface NotificationDao {
	//---------------------------------------------수진시작
	int insertNotification(MemberNotification notice);
	//---------------------------------------------수진끝
	
	//---------------------------------- 선아 시작
	@Select("select * from member_notification where member_id = #{memberId} order by noti_created_at desc")
	List<MemberNotification> selectNotificationListByMemberId(String memberId);
	//---------------------------------- 선아 끝

}
