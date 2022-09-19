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
import com.kh.monong.inquire.model.dto.Inquire;
import com.kh.monong.member.model.dao.MemberDao;
import com.kh.monong.member.model.dto.Member;
import com.kh.monong.member.model.dto.Seller;
import com.kh.monong.member.model.dto.SellerInfo;
import com.kh.monong.member.model.dto.SellerInfoAttachment;
import com.kh.monong.subscribe.model.dto.Subscription;
import com.kh.monong.subscribe.model.dto.SubscriptionOrder;
import com.kh.monong.subscribe.model.dto.SubscriptionProduct;

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
		List<DirectProduct> prodList  = memberDao.selectDirectListBySellerId(param, rowBounds);
		for(DirectProduct prod : prodList) {
			prod.setDirectProductAttachments(selectDirectAttachments(prod.getDProductNo()));
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
	public List<SubscriptionOrder> selectSubscriptionListById(String memberId) {
		return memberDao.selectSubscriptionListById(memberId);
	}
	
	@Override
	public SubscriptionOrder selectOneSubscriptionOrder(String sOrderNo) {
		return memberDao.selectOneSubscriptionOrder(sOrderNo);
	}
	
	@Override
	public List<DirectOrder> selectDirectListByMemberId(String memberId) {
		return memberDao.selectDirectListByMemberId(memberId);
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
}
