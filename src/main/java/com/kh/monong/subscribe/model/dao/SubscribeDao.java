package com.kh.monong.subscribe.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.monong.subscribe.model.dto.CardInfo;
import com.kh.monong.subscribe.model.dto.Subscription;

import lombok.NonNull;

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

		
	// 미송코드 시작
	// 미송코드 끝
}
