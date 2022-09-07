package com.kh.monong.subscribe.model.dao;

import org.apache.ibatis.annotations.Insert;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;
import lombok.NonNull;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.Vegetables;


@Mapper
public interface SubscribeDao {

	// 선아코드 시작
	@Insert("insert into card_info values(seq_card_info_no.nextval, #{cardNo}, #{cardExpireDate}, #{cardBirthDate}, #{cardPassword}, #{customerUid})")
	int insertCardInfo(CardInfo cardInfo);
	// 선아코드 끝
	
	@Select("select * from card_info where customer_uid = #{customerUid}")
	CardInfo findCardInfoByUid(@NonNull String customerUid);
	
	@Select("select cardInfoNo from card_info where customer_uid = #{customerUid}")
	int findCardInfoNoByUid(String customerUid);
	
	@Insert("insert into Subscription values(#{sNo}, #{memberId}, #{sProductCode}, #{sExcludeVegs}, #{sDeliveryCycle}, #{sNextDeliveryDate}, default, #{sRecipient}, #{sPhone}, #{sAddress}, #{sAddressEx}, #{sDeliveryRequest}, #{cardInfoNo})")
	int insertSubscription(Subscription subscription, int cardInfoNo);
	
	@Select("select * from subscription_product where s_product_code = #{sProductCode}")
	SubscriptionProduct selectProductInfoByCode(String sProductCode);
		
	// 미송코드 시작
	@Select("select * from subscription_product")
	List<SubscriptionProduct> getSubscriptionProduct();
	
	@Select("select * from vegetables")
	List<Vegetables> getVegetables();
	// 미송코드 끝
	

}
