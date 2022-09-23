package com.kh.monong.direct.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.monong.direct.model.dto.Cart;
import com.kh.monong.direct.model.dto.DirectOrder;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;
import com.kh.monong.direct.model.dto.DirectProductOption;

@Mapper
public interface DirectDao {
	//----------------- 재경 시작
	// 상품 목록
	@Select("select d.* from direct_product d order by d_product_created_at desc")
	List<DirectProduct> selectDirectProductList(Map<String, Integer> param, RowBounds rowBounds);
		
	@Select("select * from direct_product_attachment where d_product_no = #{dProductNo}")
	List<DirectProductAttachment> selectDirectProductAttachmentList(String dProductNo);
	
	@Select("select count(*) from direct_product")
	int getTotalContent();
	
	// 최근 등록순 정렬
	@Select("select d.* from direct_product d order by d_product_created_at desc")
	List<DirectProduct> orderByCreatedAt(Map<String, Integer> param, RowBounds rowBounds);

	// 가격 높은순 정렬
	@Select("select d.* from direct_product d order by d_default_price desc")
	List<DirectProduct> orderByPriceDesc(Map<String, Integer> param, RowBounds rowBounds);
	
	// 가격 낮은순 정렬
	@Select("select d.* from direct_product d order by d_default_price asc")
	List<DirectProduct> orderByPriceAsc(Map<String, Integer> param, RowBounds rowBounds);
	
		
	// 상품 등록
	@Insert("insert into direct_product values('DP'||seq_d_product_no.nextval, #{memberId}, #{dProductName}, #{dProductContent}, default, default, #{dDefaultPrice}, #{dDeliveryFee})")
	@SelectKey(statement = "select seq_d_product_no.currval from dual", before = false, keyProperty = "dProductNo", resultType = String.class)
	int insertDirectProduct(DirectProduct directProduct);

		
	@Insert("insert into direct_product_attachment values(seq_d_product_attach_no.nextval, 'DP'||#{dProductNo}, #{dProductOriginalFilename}, #{dProductRenamedFilename})")
	int insertDirectProductAttachment(DirectProductAttachment attach);
	
	@Insert("insert into direct_product_option values ('DO'||seq_d_option_no.nextval, 'DP'||#{dProductNo}, #{dOptionName}, #{dSaleStatus}, #{dPrice}, #{dStock})")
	@SelectKey(statement = "select seq_d_option_no.currval from dual", before = false, keyProperty = "dOptionNo", resultType = String.class)
	int insertDirectProductOption(DirectProductOption dOpt);
	
	
	
	//----------------- 재경 끝
	//----------------- 민지 시작
	// 상품 상세 조회
	DirectProduct selectOneDirectProductCollection(String dProductNo);
	
	// 해당 회원 장바구니 조회
	List<Cart> selectCartListByMemberId(String memberId);
	
	// 장바구니 중복 조회
	@Select("select * from cart where d_option_no = #{optionNo} and member_id = #{memberId}")
	Cart checkCartDuplicate(Map<String, Object> cart);
	
	// 장바구니 추가
	@Select("select count(*) from cart where d_option_no = #{dOptionNo} and member_id = #{memberId}")
	int checkCountCartDuplicate(Map<String, Object> addList);

	@Update("update cart set product_count = product_count + #{productCount} where d_option_no = #{dOptionNo} and member_id = #{memberId}")
	int updateCart(Map<String, Object> addList);
	
	@Insert("insert into cart values (seq_cart_no.nextval, #{dOptionNo}, #{memberId}, #{productCount})")
	int insertCart(Map<String, Object> addList);
	
	// 장바구니 전체 삭제
	@Delete("delete from cart where member_id = #{memberId}")
	int deleteCartAll(String memberId);
	
	// 장바구니 단건 삭제
	@Delete("delete from cart where cart_no = #{cartNo}")
	int deleteCartTarget(int cartNo);

	// 장바구니 선택 삭제
	@Delete("delete from cart where cart_no = #{cartNo}")
	int deleteCartChecked(int checked);
	
	// 장바구니 수량 컨트롤러
	@Update("update cart set product_count = #{productCount} where cart_no = #{cartNo}")
	int updateCartProductCount(Map<String, Object> param);
	
	// 장바구니(주문) 추가
	@Update("update cart set product_count = #{productCount}, cart_no = seq_cart_no.nextval where d_option_no = #{dOptionNo} and member_id = #{memberId}")
	@SelectKey(statement = "select seq_cart_no.currval from dual", before = false, keyProperty = "cartNo", resultType = int.class)
	int updateCartBuyIt(Map<String, Object> param);
	
	@Insert("insert into cart values (seq_cart_no.nextval, #{dOptionNo}, #{memberId}, #{productCount})")
	@SelectKey(statement = "select seq_cart_no.currval from dual", before = false, keyProperty = "cartNo", resultType = int.class)
	int insertCartBuyIt(Map<String, Object> param);
	
	DirectProduct selectOrderListByCartNo(Object object);
	
	// 결제 처리
	@Insert("insert into direct_order values (#{dOrderNo}, #{memberId}, #{dTotalPrice}, #{dDestAddress}, #{dDestAddressEx}, #{dDeliveryRequest}, #{dRecipient}, #{dOrderPhone}, default, #{dPayments}, #{dOrderStatus})")
	int insertDirectOrder(DirectOrder directOrder);
	
	@Insert("insert into member_direct_order values (#{dOptionNo}, #{dOrderNo}, #{dOptionCount}, #{dProductNo})")
	int insertMemberDirectOrder(Map<String, Object> param);
	
	@Update("update direct_product_option set d_stock = d_stock - #{dOptionCount} where d_option_no = #{dOptionNo}")
	int updateStockByOptionNo(Map<String, Object> param);
	
	@Delete("delete from cart where d_option_no = #{dOptionNo} and member_id = #{memberId}")
	int deleteCartByOptionNoAndMemberId(Map<String, Object> param);
	
	@Update("update direct_product_option set d_sale_status = '판매마감' where d_stock = 0 and d_sale_status = '판매중'")
	int updateStatusByStock();
	//----------------- 민지 끝

	//----------------- 수진 시작
	List<DirectProduct> adminSelectProdList(Map<String, Object> param);

	@Select("select * from direct_product_attachment where d_product_no = #{dProductNo}")
	List<DirectProductAttachment> selectDirectAttachments(String dProductNo);

	@Select(" select count(*) from (select distinct d_product_no from direct_product left join direct_product_option using(d_product_no) where d_sale_status = #{dSaleStatus})")
	int getTotalProdCntByStatus(Map<String, Object> param);

	@Select("select * from direct_product_attachment where d_product_attach_no = #{attachNo}")
	DirectProductAttachment selectOneDPAttachment(int attachNo);

	@Delete("delete from direct_product_attachment where d_product_attach_no = #{attachNo}")
	int deleteDPAttachment(int attachNo);

	int updateDirectProduct(DirectProduct directProduct);

	int mergeIntoDOption(DirectProductOption dOpt);

	@Insert("insert into direct_product_attachment values(seq_d_product_attach_no.nextval, #{dProductNo}, #{dProductOriginalFilename}, #{dProductRenamedFilename})")
	int insertDPAttachment(DirectProductAttachment attach);
	//----------------- 수진 끝


}