package com.kh.monong.direct.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class DirectProduct extends DirectProductEntity {
	private List<DirectProductAttachment> directProductAttachments = new ArrayList<>();
	private List<DirectProductOption> directProductOptions = new ArrayList<>();
	
	public DirectProduct(String dProductNo, String memberId, String dProductName, String dProductContent,
			LocalDateTime dProductCreatedAt, LocalDateTime dProductUpdatedAt, int dDefaultPrice) {
		super(dProductNo, memberId, dProductName, dProductContent, dProductCreatedAt, dProductUpdatedAt, dDefaultPrice);
	}
	
	
}
