package com.kh.monong.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.monong.direct.model.dto.DirectInquire;
import com.kh.monong.direct.model.dto.DirectInquireAnswer;
import com.kh.monong.direct.model.dto.DirectOrder;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;
import com.kh.monong.direct.model.dto.DirectProductEntity;
import com.kh.monong.direct.model.dto.DirectReview;
import com.kh.monong.direct.model.dto.DirectReviewAttachment;
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

@Mapper
public interface MemberDao {

	//------------------------수진 시작
	@Select("select * from member where member_id = #{memberId}")
	Member selectMemberById(String memberId);
	
	@Select("select * from member where member_email = #{email} and member_quit_date is null")
	Member selectmemberByEmail(String email);

	@Insert("insert into member values(#{memberId}, #{memberName}, #{memberPassword}, #{memberEmail}, #{memberAddress}, #{memberAddressEx}, #{memberPhone}, #{memberBirthday}, default, default, null, 'Y')")
	int insertMember(Member member);

	@Insert("insert into member_authority values(#{memberAuth}, #{memberId})")
	int insertMemberAuth(Map<String, Object> memberAuthMap);

	
	int insertEmailIdentify(Map<String, Object> map);
	
	@Select("select identify_key from member_email_identify where member_email = #{email}")
	String getEmailKey(String email);
	
	@Insert("insert into seller_info values(#{memberId}, #{sellerRegNo}, #{sellerName}, 'REG_W', null, null, default)")
	int insertSellerInfo(SellerInfo sellerInfo);
	
	@Insert("insert into seller_info_attachment values(seq_seller_attach_no.nextval, #{memberId}, #{originalFilename}, #{renamedFilename})")
	int insertSellerInfoAttachment(SellerInfoAttachment attachment);
	
	@Select("select * from seller_info where member_id = #{memberId}")
	SellerInfo selectSellerInfo(String memberId);
	
	List<DirectProduct> selectDirectListBySellerId(Map<String, Object> param, RowBounds rowBounds);
	
	@Select("select * from direct_product_attachment where d_product_no = #{dProductNo}")
	List<DirectProductAttachment> selectDirectAttachments(String dProductNo);
	
	int getTotalProdCntBySeller(Map<String, Object> param);
	
	List<Map<String, Object>> selectOrderListByProdNo(Map<String, Object> param, RowBounds rowBounds);
	
	int getTotalOrderCntByProdNo(Map<String, Object> param);

	@Update("update direct_order set d_order_status = #{newStatus} where d_order_no = #{dOrderNo}")
	int updateDOrderStatus(Map<String, Object> param);	
	
	@Select("select * from seller_info_attachment where seller_attach_no = #{no}")
	SellerInfoAttachment selectSellerInfoAttachment(long no);
	
	@Update("update seller_info set seller_reg_no = #{sellerRegNo}, seller_name = #{sellerName} where member_id = #{memberId}")
	int updateSellerInfo(SellerInfo sellerInfo);
	
	@Delete("delete from seller_info_attachment where seller_attach_no = #{delFileNo}")
	int deleteSellerAttachment(long delFileNo);

	List<Inquire> selectInquireList(Map<String, Object> param, RowBounds rowBounds);

	@Select("select count(*) from inquire where member_id = #{memberId}")
	int getTotalInqCntBymemberId(String memberId);

	@Select("update direct_product_option  set d_stock = d_stock + 1 where d_option_no in(select d_option_no  from member_direct_order where d_order_no = #{dOrderNo})")
	int reStoreDirectProductStock(String dOrderNo);

	List<DirectInquire> selectDirectInqList(Map<String, Object> param, RowBounds rowBounds);
	
	@Select("select count(*) from direct_inquire di left join direct_inquire_answer dia on di.d_inquire_no = dia.d_inquire_no where d_product_no in (select d_product_no from direct_product where member_id = #{memberId})")
	int getTotalDirectInqCntBysellerId(String sellerId);

	@Insert("insert into direct_inquire_answer values(#{dInquireNo}, #{dInquireAContent}, current_date)")
	int insertDirectInquireAnswer(DirectInquireAnswer directInqAnswer);

	@Update("update direct_inquire set has_answer = 'Y' where d_inquire_no = #{dInquireNo}")
	int updateDirectInquireAnswered(String dInquireNo);

	//------------------------수진 끝 
	
	//------------------------수아 시작

	@Select("select * from member where member_name = #{name} and member_email = #{email}")
	Member findMemberId(Map<String, Object> map);

	@Update("update member set member_password = #{memberTempPw} where member_email = #{email}")
	int updateTempPw(Map<String, Object> map);

	@Update("update member set member_name=#{memberName}, member_birthday = #{memberBirthday}, member_email = #{memberEmail}, member_phone = #{memberPhone}, member_address=#{memberAddress}, member_address_ex=#{memberAddressEx} where member_id = #{memberId}")
	int updateMember(Member member);

	@Update("update member set member_password = #{encodedPassword} where member_id= #{memberId}")
	int updatePw(Map<String, Object> map);

	@Select("select d_product_name from direct_product where d_product_no = #{prodNo}")
	String selectProdNameByNo(String prodNo);
	
	List<Member> findAllMember(RowBounds rowBounds);
	
	@Select("select count(*) from member_authority where auth= 'ROLE_MEMBER'")
	int getTotalMember();

	@Select("select count(*)  from  seller_info  where  seller_status = 'REG_O'")
	int getTotalSeller();

	List<Seller> findAllSeller(RowBounds rowBounds);

	@Select("select count(*)  from  seller_info  where  seller_status = 'REG_W'")
	int getTotalWaitSeller();

	List<Seller> findWaitSeller(RowBounds rowBounds);

	@Select("select * from seller_info_attachment where seller_attach_no = #{no}")
	SellerInfoAttachment selectSellerAttach(int no);

	@Update("update seller_info set seller_enroll_date=sysdate, seller_status='REG_O' where member_id=#{id}")
	int updateSellerStatus(String id);

	int getTotalSellerEnrollByMonth();

	Subscription selectRecentSubById(String memberId);

	@Select("select * from subscription_product where s_product_code = #{pCode}")
	SubscriptionProduct selectRecentSubProduct(String pCode);

	@Delete("delete from member where member_id = #{memberId}")
	int deleteSeller(String memberId);
	
	int updateSubscribeOrder(Subscription subscription);

	List<SubscriptionOrderExt> selectSubscriptionListById(String memberId);
	
	@Select("select * from subscription_order where s_order_no = #{sOrderNo}")
	SubscriptionOrder selectOneSubscriptionOrder(String sOrderNo);

	@Select("select * from direct_order where member_id = #{memberId} order by d_order_no desc")
	List<DirectOrder> selectDirectListByMemberId(Map<String, Object> param, RowBounds rowBounds);

	List<DirectProductEntity> selectProdListBydOrderNo(String dOrderNo);

	@Select("select * from direct_product_attachment where d_product_no = #{dProductNo}")
	List<DirectProductAttachment> selectProdAttach(String dProductNo);

	@Select("select * from direct_order where d_order_no = #{dOrderNo}")
	DirectOrder selectOneDirectOrder(String dOrderNo);

	List<Map<String, Object>> selectDirectOptionList(String dOrderNo);

	@Update("update direct_order set d_order_status='C' where d_order_no = #{dOrderNo}")
	int deleteMemberDirectOrder(String dOrderNo);

	@Update("update subscription set s_quit_yn = 'Y' where s_no = #{sNo}")
	int deleteMemberSubscribeOrder(String sNo);

	//------------------------수아 끝
	//-----------미송 시작
	@Insert("insert into subscription_review values('SR' || seq_s_review_no.nextval, #{sOrderNo}, #{sReviewContent}, #{sReviewStar}, default, default, null)")
	@SelectKey(statement = "select 'SR' || seq_s_review_no.currval from dual", before = false, keyProperty = "sReviewNo", resultType = String.class)
	int insertSubscriptionReview(SubscriptionReview review);

	@Insert("insert into subscription_review_attachment values (seq_s_attach_no.nextval, #{sReviewNo}, #{sReviewOriginalFilename}, #{sReviewRenamedFilename}, DEFAULT)")
	int insertSubscriptionReviewAttachment(SubscriptionReviewAttachment attach);
	
	@Select("select count(*) from subscription_review where s_order_no = #{sOrderNo}")
	int getSubscriptionReviewYn(String sOrderNo);

	List<SubscriptionReview> selectSubscriptionReviewList(RowBounds rowBounds, String memberId);

	
	int getTotalContent(String memberId);
	//-----------미송 끝

	//---------------수아시작
	Map<String, Object> selectReviewDirectProduct(Map<String, Object> map);

	List<Map<String, Object>> selectDirectReviewProdList(Map<String, Object> param, RowBounds rowBounds);

	@Insert("insert into direct_review values('SR'||seq_d_review_no.nextval, #{dOptionNo}, #{dOrderNo}, #{dReviewTitle}, #{memberId}, #{dReviewContent}, #{reviewRating}, default, default, null)")
	@SelectKey(statement = "select 'SR'||seq_d_review_no.currval from dual", before=false, keyProperty="dReviewNo", resultType = String.class)
	int insertDirectReview(DirectReview directReview);

	@Insert("insert into direct_review_attachment values(seq_d_review_attach_no.nextval, #{dReviewNo}, #{dReviewOriginalFilename}, #{dReviewRenamedFilename}, default)")
	int insertDirectReviewAttachment(DirectReviewAttachment directReviewAttach);

	List<Map<String, Object>> selectDirectReviewList(Map<String, Object> param, RowBounds rowBounds);

	@Select("select count(*) from direct_order where member_id=#{memberId}")
	int getTotalDirectList(String memberId);

	@Select("select count(*) from direct_review where member_id=#{memberId}")
	int getTotalDirectReviewByMemberId(String memberId);

	@Delete("delete from direct_review where d_review_no = #{dReviewNo}")
	int deleteDirectReview(String dReviewNo);

	Map<String, Object> selectDirectReview(String dReviewNo);

	@Delete("delete from direct_review_attachment where d_review_attach_no = #{delFileNo}")
	int deleteDirectReviewAttachment(int delFileNo);

	@Select("select * from direct_review_attachment where d_review_attach_no = #{dReviewAttachNo}")
	DirectReviewAttachment selectDirectReviewAttach(int dReviewAttachNo);

	@Update("update direct_review set d_review_title=#{dReviewTitle}, d_review_content=#{dReviewContent}, review_rating=#{reviewRating}, d_review_updated_at= sysdate where d_review_no = #{dReviewNo}")
	int updateDirectReview(DirectReview directReview);

	@Select("select count(*) from direct_order where member_id=#{memberId} and d_order_status='F'")
	int getTotalDirectEnrollReviewByMemberId(String memberId);
	//------------------수아끝

	Map<String, Object> selectSubscriptionOrderBySOrderNo(String sOrderNo);

	
}
