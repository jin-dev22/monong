package com.kh.monong.direct.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.monong.direct.model.dto.DirectProduct;

public interface DirectDao {
	
	@Select("select p.*, (select count(*) from direct_product_attachment where d_product_no = p.no) attach_count from direct_product p order by direct_product_no desc")
	List<DirectProduct> selectProductList(RowBounds rowBounds);
	
	@Select("select count(*) from board")
	int getDirectProductTotalContent();

}
