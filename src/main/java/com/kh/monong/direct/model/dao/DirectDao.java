package com.kh.monong.direct.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.monong.direct.model.dto.DirectProduct;

@Mapper
public interface DirectDao {

	@Select("select d.*, (select count(*) from direct_product_attachment where d_product_no = d.d_product_no) attach_count from direct_product d order by d_product_no desc")
	List<DirectProduct> selectDirectProductList();

	DirectProduct selectOneDirectProductCollection(String dProductNo);
	
	

}
