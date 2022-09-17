package com.kh.monong.subscribe.model.dao;

import org.apache.ibatis.annotations.Insert;

import java.time.LocalDate;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;

import lombok.NonNull;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.Vegetables;


@Mapper
public interface SubscribeDao {

	// 선아코드 시작
	@Insert("insert into card_info values(seq_card_info_no.nextval, #{cardNo}, #{cardExpireDate}, #{cardBirthDate}, #{cardPassword}, #{customerUid})")
	int insertCardInfo(CardInfo cardInfo);
	
	@Select("select card_info_no from card_info where customer_uid = #{customerUid}")
	int findCardInfoNoByUid(String customerUid);
	
	@Insert("insert into subscription values(#{sNo}, #{cardInfoNo}, #{memberId}, #{sProductCode}, #{sExcludeVegs}, #{sDeliveryCycle}, #{sNextDeliveryDate}, default, #{sRecipient}, #{sPhone}, #{sAddress}, #{sAddressEx}, #{sDeliveryRequest}, default, #{sPaymentDate})")
	int insertSubscription(Subscription subscription);
	
	// 현재 미사용
	@Insert("insert into subscription_order values(#{sOrderNo}, #{sNo}, default, #{sPrice}, default, default)")
	int insertSubscriptionOrder(SubscriptionOrder subscriptionOrder);
	
	@Select("select * from subscription where s_no = #{sNo}")
	Subscription selectSubscription(String sNo);
	
	@Select("select * from subscription_product where s_product_code = #{sProductCode}")
	SubscriptionProduct selectProductInfoByCode(String sProductCode);
	
	@Select("select s.*, ci.* from subscription s left join card_info ci on s.card_info_no = ci.card_info_no where customer_uid = #{customerUid}")
	Subscription findNextDeliveryDateByUid(String customerUid);
	
	
	
	// 선아코드 끝
	
	// 미송코드 시작
	@Select("select * from subscription_product")
	List<SubscriptionProduct> getSubscriptionProduct();
	
	@Select("select * from vegetables")
	List<Vegetables> getVegetables();
	
	@Select("select avg(s_review_star) from subscription_review")
	int getSubscriptionReviewStarAvg();
	
	@Select("select count(*) from subscription_review")
	int getTotalContent();
	
	List<SubscriptionReview> selectSubscriptionReviewListCollection(RowBounds rowBounds);

	SubscriptionReview selectOneSubscriptionReviewCollection(String sReviewNo);

	@Update("update subscription_review set s_review_recommend_num  = s_review_recommend_num + 1 where s_review_no = #{sReviewNo}")
	int updateSubscribeReviewRecommend(String sReviewNo);
	
	// 추가
	@Select("select s_no from subscription where member_id = #{memberId} and s_quit_yn = 'N'")
	String getSubscriptionByMemberId(String memberId);
	
	// 미송코드 끝

}
