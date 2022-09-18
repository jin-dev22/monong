package com.kh.monong.direct.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
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

	@Insert("insert into direct_product_attachment values(seq_d_product_attach_no.nextval, #{dProductNo}, #{dProductOriginalFilename}, #{dProductRenamedFilename})")
	int insertDirectProductAttachment(DirectProductAttachment attach);
	
	//----------------- 재경 끝
	//----------------- 민지 시작
	DirectProduct selectOneDirectProductCollection(String dProductNo);
	
	@Select("select * from cart where d_option_no = #{optionNo} and member_id = #{memberId}")
	Cart checkCartDuplicate(Map<String, Object> cart);
	//----------------- 민지 끝

	




	


	

}