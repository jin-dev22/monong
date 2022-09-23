package com.kh.monong.subscribe.model.dao;

import org.apache.ibatis.annotations.Insert;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;

import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.SubscriptionWeekVegs;
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
	
	@Select("select * from subscription where s_no = #{sNo}")
	Subscription selectSubscription(String sNo);
	
	@Select("select * from subscription_product where s_product_code = #{sProductCode}")
	SubscriptionProduct selectProductInfoByCode(String sProductCode);
	
	@Select("select s.* from subscription s where s.s_payment_date = #{today} and s_quit_yn = 'N' and not exists (select 1 from subscription_order so where s.s_no = so.s_no and so.s_order_status = '상품준비중' and so.s_order_date >= #{today} and s_order_date < to_date(#{today}) + 0.99999)")
	List<Subscription> getPayList(LocalDate today);
	
	@Select("select * from subscription_product where s_product_code = #{sProductCode}")
	SubscriptionProduct getAmountByPcode(String sProductCode);
	
	@Select("select * from card_info where card_info_no = #{cardNo}")
	CardInfo getCardInfoList(int cardNo);
	
	@Select("select * from subscription_order where s_no = #{sNo}")
	SubscriptionOrder getTimesBysNo(String sNo);
	
	@Insert("insert into subscription_order values(#{sOrderNo}, #{sNo}, #{sTimes}, #{sPrice}, default, default, #{soCardInfoNo}, #{soProductCode}, #{soExcludeVegs}, #{soDeliveryCycle}, #{soDeliveryDate}, #{soDelayYn}, #{soRecipient}, #{soPhone}, #{soAddress}, #{soAddressEx}, #{soDeliveryRequest}, default)")
	int insertSubOrder(SubscriptionOrder subOrder);
	
	@Update("update subscription set s_delay_yn = #{sDelayYn}, s_payment_date = #{sPaymentDate}, s_next_delivery_date = #{sNextDeliveryDate} where s_no = #{sNo}")
	int updateSubscriptionSuccessPay(Subscription updateSub);
	
	/**
	 * 관리자
	 */
	@Select("select * from subscription where s_quit_yn = 'N' order by card_info_no desc")
	List<Subscription> getSubscriptionListAll(RowBounds rowBounds);
	
	@Select("select count(*) from subscription where s_quit_yn = 'N'")
	int getTotalSubscriptionListAll();
	
	@Select("select * from subscription where s_quit_yn = #{selectOption}")
	List<Subscription> findByQuitYnSubList(String selectOption, RowBounds rowBounds);
	
	@Select("select count(*) from subscription where s_quit_yn = #{selectOption}")
	int getTotalFindByQuitYnSubList(String selectOption);
	
	@Select("select * from subscription_order where s_order_status = #{deliveryStatus}")
	List<SubscriptionOrder> getSubscriptionOrderListAll(RowBounds rowBounds, String deliveryStatus);
	
	@Select("select count(*) from subscription_order where s_order_status = #{deliveryStatus}")
	int getTotalSubscriptionOrderListAll(String deliveryStatus);
	
	int updateSubDelivery(Map<String, Object> param);
	
	@Select("select * from subscription_order where so_delivery_date = #{today}")
	List<SubscriptionOrder> getSubOrderList(LocalDate today);
	
	@Select("select * from subscription_order where so_delivery_completed_date between to_date(#{searchStartDate}) and to_date(#{searchEndDate})+ 0.99999 and s_order_status = #{deliveryStatus}")
	List<SubscriptionOrder> searchPeriodData(RowBounds rowBounds, Map<String, Object> param);
	
	@Select("select count(*) from subscription_order where so_delivery_completed_date between to_date(#{searchStartDate}) and to_date(#{searchEndDate})+ 0.99999 and s_order_status = #{deliveryStatus}")
	int getTotalsearchPeriodData(Map<String, Object> param);
	
	/**
	 * 주간채소 팝업
	 */
	@Select("select * from subscription_week_vegs where week_criterion = #{weekCriterion}")
	SubscriptionWeekVegs getWeekVegsNotice(String weekCriterion);
	
	
	// 선아코드 끝
	
	// 미송코드 시작
	@Select("select * from subscription_product")
	List<SubscriptionProduct> getSubscriptionProduct();
	
	@Select("select * from vegetables")
	List<Vegetables> getVegetables();
	
	@Select("select round(avg(s_review_star),1) from subscription_review")
	double getSubscriptionReviewStarAvg();
	
	@Select("select count(*) from subscription_review")
	int getTotalContent();
	
	List<SubscriptionReview> selectSubscriptionReviewListCollection(RowBounds rowBounds);

	SubscriptionReview selectOneSubscriptionReviewCollection(String sReviewNo);
	
	@Select("select count(*) from recommended_subscription_review where member_id = #{memberId} and s_review_no = #{sReviewNo}")
	int getRecommendedYn(Map<String, String> param);
	
	@Update("update subscription_review set s_review_recommend_num  = s_review_recommend_num + 1 where s_review_no = #{sReviewNo}")
	int updateSubscribeReviewRecommendAdd(Map<String, String> param);

	@Insert("insert into recommended_subscription_review values(#{memberId}, #{sReviewNo})")
	int insertRecommendedSubscribeReview(Map<String, String> param);

	@Update("update subscription_review set s_review_recommend_num  = s_review_recommend_num - 1 where s_review_no = #{sReviewNo}")
	int updateSubscribeReviewRecommendCancel(Map<String, String> param);

	@Insert("delete recommended_subscription_review where member_id = #{memberId} and s_review_no = #{sReviewNo}")
	int deleteRecommendedSubscribeReview(Map<String, String> param);
	
	// 추가
	@Select("select s_no from subscription where member_id = #{memberId} and s_quit_yn = 'N'")
	String getSubscriptionByMemberId(String memberId);










	
	
	
	// 미송코드 끝

}
