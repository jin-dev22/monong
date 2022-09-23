package com.kh.monong.notice.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.monong.notice.model.dto.MemberNotification;

@Mapper
public interface NotificationDao {

	@Select("select * from member_notification where member_id = #{memberId} where noti_created_at desc")
	List<MemberNotification> selectNotificationListByMemberId(String memberId);

}
