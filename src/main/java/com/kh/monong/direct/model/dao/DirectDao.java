package com.kh.monong.direct.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.monong.direct.model.dto.Cart;
import com.kh.monong.direct.model.dto.DirectProduct;
import com.kh.monong.direct.model.dto.DirectProductAttachment;

@Mapper
public interface DirectDao {
	//----------------- 재경 시작
	@Select("select d.*, (select count(*) from direct_product_attachment where d_product_no = d.d_product_no) attach_count from direct_product d order by d_product_no desc")
	List<DirectProduct> selectDirectProductList(RowBounds rowBounds);
	
	@Select("select * from direct_product_attachment")
	List<DirectProductAttachment> selectDirectProductAttachmentList();

	@Select("select count(*) from direct_product")
	int getTotalContent();
	
	// 상품 등록
	@Insert("insert into direct_product values('DP'||seq_d_product_no.nextval, #{memberId}, #{dProductName}, #{dProductContent}, default, default, #{dDefaultPrice}, #{dDeliveryFee})")
	@SelectKey(statement = "select seq_d_product_no.currval from dual", before = false, keyProperty = "dProductNo", resultType = String.class)
	int insertDirectProduct(DirectProduct directProduct);

	
	@Insert("insert into direct_product_attachment values(seq_d_product_attach_no.nextval, 'DP'||#{dProductNo}, #{dProductOriginalFilename}, #{dProductRenamedFilename})")
	int insertDirectProductAttachment(DirectProductAttachment attach);
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

	// 장바구니(주문) 추가
	@Insert("insert into cart values (seq_cart_no.nextval, #{dOptionNo}, #{memberId}, #{productCount})")
	@SelectKey(statement = "select seq_cart_no.currval from dual", before = false, keyProperty = "cartNo", resultType = int.class)
	int insertCartByIt(Map<String, Object> param);
	
	DirectProduct selectOrderListByCartNo(Object object);
	//----------------- 민지 끝

	//----------------- 수진 시작
	List<DirectProduct> adminSelectProdList(Map<String, Object> param, RowBounds rowBounds);

	@Select("select * from direct_product_attachment where d_product_no = #{dProductNo}")
	List<DirectProductAttachment> selectDirectAttachments(String dProductNo);

	@Select(" select count(*) from (select distinct d_product_no from direct_product left join direct_product_option using(d_product_no) where d_sale_status = #{dSaleStatus})")
	int getTotalProdCntByStatus(Map<String, Object> param);

	
	//----------------- 수진 시작



}