package com.kh.monong.member.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.monong.direct.model.dto.DirectInquire;
import com.kh.monong.direct.model.dto.DirectInquireAnswer;
import com.kh.monong.direct.model.dto.DirectOrder;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;
import com.kh.monong.direct.model.dto.DirectProductEntity;
import com.kh.monong.direct.model.dto.DirectReview;
import com.kh.monong.direct.model.dto.DirectReviewAttachment;
import com.kh.monong.inquire.model.dto.Inquire;
import com.kh.monong.member.model.dao.MemberDao;
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

import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	//------------------수진 시작
	@Override
	public Member selectMemberById(String memberId) {
		return memberDao.selectMemberById(memberId);
	}
	
	@Override
	public Member selectMemberByEmail(String email) {
		return memberDao.selectmemberByEmail(email);
	}
	
	@Override
	public int insertMember(Map<String, Object> memberAuthMap, Member member) {
		int result = memberDao.insertMember(member);
		log.debug("result insertMember = {}", result);
		
		//insert member auth
		result = insertMemberAuth(memberAuthMap);
		
		return result;
	}
	
	@Override
	public int insertSeller(Map<String, Object> memberAuthMap, Seller seller) {
		int result = insertMember(memberAuthMap, seller);
		result = insertSellerInfo(seller.getSellerInfo());
		result = insertSellerInfoAttachment(seller.getAttachment());
		return result;
	}
	
	@Override
	public int insertSellerInfoAttachment(SellerInfoAttachment attachment) {
		return memberDao.insertSellerInfoAttachment(attachment);
	}
	
	@Override
	public int insertSellerInfo(SellerInfo sellerInfo) {
		return memberDao.insertSellerInfo(sellerInfo);
	}

	@Override
	public int insertMemberAuth(Map<String, Object> memberAuthMap) {
		return memberDao.insertMemberAuth(memberAuthMap);
	}
	
	@Override
	public int insertEmailIdentify(Map<String, Object> map) {
		return memberDao.insertEmailIdentify(map);
	}
	
	@Override
	public String getEmailKey(String email) {
		return memberDao.getEmailKey(email);
	}
	
	@Override
	public SellerInfo selectSellerInfo(String memberId) {
		return memberDao.selectSellerInfo(memberId);
	}
	
	@Override
	public List<DirectProduct> selectDirectListBySellerId(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		log.debug("limit = {}, offset = {}", limit, offset);
		List<DirectProduct> prodList  = memberDao.selectDirectListBySellerId(param, rowBounds);
		for(DirectProduct prod : prodList) {
			prod.setDirectProductAttachments(selectDirectAttachments(prod.getDProductNo()));
			log.debug("prod={}",prod);
		}
		return prodList;
	}
	
	private List<DirectProductAttachment> selectDirectAttachments(String dProductNo) {
		return memberDao.selectDirectAttachments(dProductNo);
	}
	
	@Override
	public int getTotalProdCntBySeller(Map<String, Object> param) {
		return memberDao.getTotalProdCntBySeller(param);
	}
	
	@Override
	public List<Map<String, Object>> selectOrderListByProdNo(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.selectOrderListByProdNo(param, rowBounds);
	}
	
	@Override
	public int getTotalOrderCntByProdNo(Map<String, Object> param) {
		return memberDao.getTotalOrderCntByProdNo(param);
	}
	
	@Override
	public String selectProdNameByNo(String prodNo) {
		return memberDao.selectProdNameByNo(prodNo);
	}
	
	@Override
	public int updateDOrderStatus(Map<String, Object> param) {
		if("C".equals(param.get("newStatus"))) {
			int result = reStoreDirectProductStock((String)param.get("dOrderNo"));
		}//재고 복구시 판매상태 '판매중'으로 변경되도록 트리거 생성.
		return memberDao.updateDOrderStatus(param);
	}
	
	private int reStoreDirectProductStock(String dOrderNo) {
		return memberDao.reStoreDirectProductStock(dOrderNo);
	}

	@Override
	public SellerInfoAttachment selectSellerInfoAttachment(long no) {
		return memberDao.selectSellerInfoAttachment(no);
	}
	
	@Override
	public int updateSeller(Seller seller) {
		int result = updateMember(seller);
		result = updateSellerInfo(seller.getSellerInfo());
		if(seller.getAttachment() != null) {
			result = insertSellerInfoAttachment(seller.getAttachment());
		}
		return result;
	}
	

	private int updateSellerInfo(SellerInfo sellerInfo) {
		return memberDao.updateSellerInfo(sellerInfo);
	}
	
	
	@Override
	public int deleteSellerAttachment(long delFileNo) {
		return memberDao.deleteSellerAttachment(delFileNo);
	}
	
	@Override
	public List<Inquire> selectInquireList(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.selectInquireList(param, rowBounds);
	}
	
	@Override
	public int getTotalInqCntBymemberId(String memberId) {
		return memberDao.getTotalInqCntBymemberId(memberId);
	}
	
	@Override
	public List<DirectInquire> selectDirectInqList(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.selectDirectInqList(param, rowBounds);
	}
	
	@Override
	public int getTotalDirectInqCntBysellerId(String sellerId) {
		return memberDao.getTotalDirectInqCntBysellerId(sellerId);
	}
	
	@Override
	public int insertDirectInquireAnswer(DirectInquireAnswer directInqAnswer) {
		int result = memberDao.insertDirectInquireAnswer(directInqAnswer);
		result = updateDirectInquireAnswered(directInqAnswer.getDInquireNo());
		return result;
	};
	
	private int updateDirectInquireAnswered(@NonNull String dInquireNo) {
		return memberDao.updateDirectInquireAnswered(dInquireNo);
	}

	//------------------수진 끝
	
	//------------------수아 시작
	
	@Override
	public Member findMemberId(Map<String, Object> map) {
		return memberDao.findMemberId(map);
	}
	
	@Override
	public int updateTempPw(Map<String, Object> map) {
		return memberDao.updateTempPw(map);
	}
	
	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}
	
	@Override
	public int updatePw(Map<String, Object> map) {
		return memberDao.updatePw(map);
	}

	@Override
	public int getTotalMember() {
		return memberDao.getTotalMember();
	}

	@Override
	public List<Member> findAllMember(Map<String, Integer> param) {
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.findAllMember(rowBounds);
	}
	
	@Override
	public int getTotalSeller() {
		return memberDao.getTotalSeller();
	}
	
	@Override
	public List<Seller> findAllSeller(Map<String, Integer> param) {
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.findAllSeller(rowBounds);
	}
	
	@Override
	public int getTotalWaitSeller() {
		return memberDao.getTotalWaitSeller();
	}
	
	@Override
	public int getTotalSellerEnrollByMonth() {
		return memberDao.getTotalSellerEnrollByMonth();
	}
	
	@Override
	public List<Seller> findWaitSeller(Map<String, Integer> param) {
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.findWaitSeller(rowBounds);
	}
	
	@Override
	public SellerInfoAttachment selectSellerAttach(int no) {
		return memberDao.selectSellerAttach(no);
	}
	
	@Override
	public int updateSellerStatus(String id) {
		return memberDao.updateSellerStatus(id);
	}
	
	
	@Override
	public int deleteSeller(String memberId) {
		return memberDao.deleteSeller(memberId);
	}
	
	@Override
	public Subscription selectRecentSubById(String memberId) {
		return memberDao.selectRecentSubById(memberId);
	}
	
	@Override
	public SubscriptionProduct selectRecentSubProduct(String pCode) {
		return memberDao.selectRecentSubProduct(pCode);
	}
	
	@Override
	public int updateSubscribeOrder(Subscription subscription) {
		return memberDao.updateSubscribeOrder(subscription);
	}
	
	@Override
	public List<SubscriptionOrderExt> selectSubscriptionListById(String memberId) {
		return memberDao.selectSubscriptionListById(memberId);
	}
	
	@Override
	public SubscriptionOrder selectOneSubscriptionOrder(String sOrderNo) {
		return memberDao.selectOneSubscriptionOrder(sOrderNo);
	}
	
	@Override
	public List<DirectOrder> selectDirectListByMemberId(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.selectDirectListByMemberId(param, rowBounds);
	}
	
	@Override
	public List<DirectProductEntity> selectProdListBydOrderNo(String dOrderNo) {
		return memberDao.selectProdListBydOrderNo(dOrderNo);
	}
	
	@Override
	public List<DirectProductAttachment> selectProdAttach(String dProductNo) {
		return memberDao.selectProdAttach(dProductNo);
	}
	
	@Override
	public DirectOrder selectOneDirectOrder(String dOrderNo) {
		return memberDao.selectOneDirectOrder(dOrderNo);
	}
	
	@Override
	public List<Map<String, Object>> selectDirectOptionList(String dOrderNo) {
		return memberDao.selectDirectOptionList(dOrderNo);
	}
	
	@Override
	public int deleteMemberDirectOrder(String dOrderNo) {
		return memberDao.deleteMemberDirectOrder(dOrderNo);
	}
	
	@Override
	public int deleteMemberSubscribeOrder(String sNo) {
		return memberDao.deleteMemberSubscribeOrder(sNo);
	}
	//------------------수아 끝
	
	//-----------미송 시작
	@Override
	public int insertSubscriptionReview(SubscriptionReview review) {
		int result = memberDao.insertSubscriptionReview(review);
		List<SubscriptionReviewAttachment> attachments = review.getSAttachments();
		
		if(!attachments.isEmpty()) {
			for(SubscriptionReviewAttachment attach : attachments) {
				attach.setSReviewNo(review.getSReviewNo());
				result = insertSubscriptionReviewAttachment(attach);
			}
		}

		return result;
	}
	
	private int insertSubscriptionReviewAttachment(SubscriptionReviewAttachment attach) {
		return memberDao.insertSubscriptionReviewAttachment(attach);
	}
	
	@Override
	public int getSubscriptionReviewYn(String sOrderNo) {
		return memberDao.getSubscriptionReviewYn(sOrderNo);
	}
	
	@Override
	public List<SubscriptionReview> selectSubscriptionReviewList(Map<String, Integer> param, String memberId) {
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return memberDao.selectSubscriptionReviewList(rowBounds, memberId);
	}

	@Override
	public int getTotalContent(String memberId) {
		return memberDao.getTotalContent(memberId);
	}
	
	//-----------미송 끝

	//----------수아 시작
	@Override
	public Map<String, Object> selectReviewDirectProduct(Map<String, Object> map) {
		return memberDao.selectReviewDirectProduct(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDirectReviewProdList(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.selectDirectReviewProdList(param, rowBounds);
	}
	
	@Override
	public int insertDirectReview(DirectReview directReview) {
		int result = memberDao.insertDirectReview(directReview);
		log.debug("directReview#dReviewNo={}", directReview.getDReviewNo());
		if(directReview.getDirectReviewAttach() != null) {
			directReview.getDirectReviewAttach().setDReviewNo(directReview.getDReviewNo());
			result = memberDao.insertDirectReviewAttachment(directReview.getDirectReviewAttach());
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> selectDirectReviewList(Map<String, Object> param) {
		int limit = (int) param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return memberDao.selectDirectReviewList(param, rowBounds);
	}
	@Override
	public int getTotalDirectList(String memberId) {
		return memberDao.getTotalDirectList(memberId);
	}
	
	@Override
	public int getTotalDirectReviewByMemberId(String memberId) {
		return memberDao.getTotalDirectReviewByMemberId(memberId);
	}
	
	@Override
	public int deleteDirectReview(String dReviewNo) {
		return memberDao.deleteDirectReview(dReviewNo);
	}
	
	@Override
	public Map<String, Object> selectDirectReview(String dReviewNo) {
		return memberDao.selectDirectReview(dReviewNo);
	}
	
	@Override
	public int deleteDirectReviewAttachment(int delFileNo) {
		return memberDao.deleteDirectReviewAttachment(delFileNo);
	}
	
	@Override
	public int updateDirectReview(DirectReview directReview) {
		int result = memberDao.updateDirectReview(directReview);
		log.debug("directReviewUpdate#dReviewNo={}", directReview.getDReviewNo());
		
		if(directReview.getDirectReviewAttach() != null) {
			result = memberDao.insertDirectReviewAttachment(directReview.getDirectReviewAttach());
			}
			return result;
	}
	
	@Override
	public DirectReviewAttachment selectDirectReviewAttach(int dReviewAttachNo) {
		return memberDao.selectDirectReviewAttach(dReviewAttachNo);
	}
	
	@Override
	public int getTotalDirectEnrollReviewByMemberId(String memberId) {
		return memberDao.getTotalDirectEnrollReviewByMemberId(memberId);
	}
	
	@Override
	public Map<String, Object> selectSubscriptionOrderBySOrderNo(String sOrderNo) {
		return memberDao.selectSubscriptionOrderBySOrderNo(sOrderNo);
	}
	//------------수아 끝
}
