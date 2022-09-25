package com.kh.monong.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.monong.direct.model.dto.DirectInquire;
import com.kh.monong.direct.model.dto.DirectInquireAnswer;
import com.kh.monong.direct.model.dto.DirectOrder;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;
import com.kh.monong.direct.model.dto.DirectProductEntity;
import com.kh.monong.direct.model.dto.DirectReview;
import com.kh.monong.direct.model.dto.DirectReviewAttachment;
import com.kh.monong.direct.model.dto.MemberDirectOrder;
import com.kh.monong.inquire.model.dto.Inquire;
import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.Seller;
import com.kh.monong.member.model.dto.SellerInfo;
import com.kh.monong.member.model.dto.SellerInfoAttachment;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;
import com.kh.monong.subscribe.model.dto.SubscriptionOrderExt;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;
import com.kh.monong.subscribe.model.dto.SubscriptionReview;
import com.kh.monong.subscribe.model.dto.SubscriptionReviewAttachment;

public interface MemberService {
//-----------수진시작
	Member selectMemberById(String memberId);
	
	Member selectMemberByEmail(String email);
	
	int insertMember(Map<String, Object> memberAuthMap, Member member);
	
	int insertMemberAuth(Map<String, Object> memberAuthMap);
	
	int insertEmailIdentify(Map<String, Object> map);
	
	String getEmailKey(String email);
	
	
	int insertSeller(Map<String, Object> memberAuthMap, Seller seller);

	int insertSellerInfo(SellerInfo sellerInfo);
	
	int insertSellerInfoAttachment(SellerInfoAttachment attachment);
	
	SellerInfo selectSellerInfo(String memberId);
	
	List<DirectProduct> selectDirectListBySellerId(Map<String, Object> param);
	
	/**
	 * 판매자 판매상품 개수
	 */
	int getTotalProdCntBySeller(Map<String, Object> param);
	
	List<Map<String, Object>> selectOrderListByProdNo(Map<String, Object> param);
	
	int getTotalOrderCntByProdNo(Map<String, Object> param);

	String selectProdNameByNo(String prodNo);

	int updateDOrderStatus(Map<String, Object> param);
	
	Integer reStoreDirectProductStock(MemberDirectOrder mDO);
	
	SellerInfoAttachment selectSellerInfoAttachment(long delFileNo);
	
	int updateSeller(Seller seller);

	int deleteSellerAttachment(long delFileNo);
	
	List<Inquire> selectInquireList(Map<String, Object> param);
	
	int getTotalInqCntBymemberId(String memberId);

	List<DirectInquire> selectDirectInqList(Map<String, Object> param);

	int getTotalDirectInqCntBysellerId(String sellerId);
	
	int insertDirectInquireAnswer(DirectInquireAnswer directInqAnswer);

	List<Map<String,Object>> selectOrderListBySeller(Map<String, Object> param);

	int getTotalOrderCntBySeller(Map<String, Object> param);

	int memberQuit(String memberId);

	int deleteMemberAuth(String memberId);
//-----------수진 끝
//-----------수아 시작
	Member findMemberId(Map<String, Object> map);

	int updateTempPw(Map<String, Object> map);
	
	int updateMember(Member member);

	int updatePw(Map<String, Object> map);
	
	List<Member> findAllMember(Map<String, Integer> param);

	int getTotalMember();

	List<Seller> findAllSeller(Map<String, Integer> param);

	int getTotalSeller();

	int getTotalWaitSeller();

	List<Seller> findWaitSeller(Map<String, Integer> param);

	SellerInfoAttachment selectSellerAttach(int no);

	int updateSellerStatus(String id);

	int getTotalSellerEnrollByMonth();

	Subscription selectRecentSubById(String memberId);

	SubscriptionProduct selectRecentSubProduct(String pCode);

	int deleteSeller(String memberId);
	
	int updateSubscribeOrder(Subscription subscription);

	List<SubscriptionOrderExt> selectSubscriptionListById(Map<String, Object> param);

	SubscriptionOrder selectOneSubscriptionOrder(String sOrderNo);

	List<Map<String, Object>> selectDirectListByMemberId(Map<String, Object> param);

	List<DirectProductEntity> selectProdListBydOrderNo(String dOrderNo);

	List<DirectProductAttachment> selectProdAttach(String dProductNo);

	DirectOrder selectOneDirectOrder(String dOrderNo);

	List<Map<String, Object>> selectDirectOptionList(String dOrderNo);

	int deleteMemberDirectOrder(String dOrderNo);

	int deleteMemberSubscribeOrder(String sNo);
//-----------수아 끝
//-----------미송 시작
	int getTotalSubscriptionContent(String memberId);
	
	int insertSubscriptionReview(SubscriptionReview review);
	
	int getSubscriptionReviewYn(String sOrderNo);
	
	List<SubscriptionReview> selectSubscriptionReviewList(Map<String, Integer> param, String memberId);
	
	int getTotalSubscriptionReviewContent(String memberId);
	
	SubscriptionReviewAttachment selectOneSubscriptionAttachment(int attachNo);

	int deleteSubscriptionAttachment(int attachNo);

	int updateSubscriptionReview(SubscriptionReview review);

	int deleteSubscriptionReview(String sReviewNo);


//----------수아 시작
	Map<String, Object> selectReviewDirectProduct(Map<String, Object> map);

	List<Map<String, Object>> selectDirectReviewProdList(Map<String, Object> param);

	int insertDirectReview(DirectReview directReview);

	List<Map<String, Object>> selectDirectReviewList(Map<String, Object> param);

	int getTotalDirectList(String memberId);

	int getTotalDirectReviewByMemberId(String memberId);

	int deleteDirectReview(String dReviewNo);

	Map<String, Object> selectDirectReview(String dReviewNo);

	int deleteDirectReviewAttachment(int delFileNo);

	int updateDirectReview(DirectReview directReview);

	DirectReviewAttachment selectDirectReviewAttach(int dReviewAttachNo);

	int getTotalDirectEnrollReviewByMemberId(String memberId);
//-----------수아 끝

	Map<String, Object> selectSubscriptionOrderBySOrderNo(String sOrderNo);

	List<DirectInquire> selectMemberDirectInqList(Map<String, Object> param);

	int getTotalMemberDirectInqList(String memberId);

	


	

	
}
