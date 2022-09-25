package com.kh.monong.notice.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.monong.notice.model.dto.MemberNotification;

@Mapper
public interface NotificationDao {
	// ---------------------------------------------수진시작
	int insertNotification(MemberNotification notice);

	@Update("update member_notification set noti_is_read = 'Y' where noti_no = #{notiNo}")
	int notificationHasRead(long notiNo);

	@Select("select * from member_notification where member_id = #{memberId} order by noti_is_read, noti_created_at desc")
	List<MemberNotification> selectNotificationListByMemberId(String memberId, RowBounds rowBounds);

	@Select("select count(*) from member_notification where member_id = #{memberId}")
	int getNoticeCount(String memberId);

	@Select("select count(*) from member_notification where member_id = #{memberId} and noti_is_read = 'N'")
	int getNewNoticeCount(String memberId);
	// ---------------------------------------------수진끝

}
