package com.kh.monong.direct.model.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Cart extends CartEntity {
	private DirectProductEntity directProduct;
	private List<DirectProductAttachment> directProductAttachments = new ArrayList<>();
	private List<DirectProductOption> directProductOptions = new ArrayList<>();
	
	public Cart(String cartNo, String dOptionNo, String memberId, int productCount) {
		super(cartNo, dOptionNo, memberId, productCount);
	}
	
	public void add(DirectProductAttachment attach){
		this.directProductAttachments.add(attach);
	}
	
}
