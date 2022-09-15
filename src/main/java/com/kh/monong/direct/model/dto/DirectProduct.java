package com.kh.monong.direct.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.kh.monong.member.model.dto.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class DirectProduct extends DirectProductEntity {
	private int attachCount;
	private Member member;
	private List<DirectProductAttachment> directProductAttachments = new ArrayList<>();
	private List<DirectProductOption> directProductOptions = new ArrayList<>();
	
	public DirectProduct(String dProductNo, String memberId, String dProductName, String dProductContent,
			LocalDateTime dProductCreatedAt, LocalDateTime dProductUpdatedAt, int dDefaultPrice, int dDeliveryFee, int attachCount) {
		super(dProductNo, memberId, dProductName, dProductContent, dProductCreatedAt, dProductUpdatedAt, dDefaultPrice, dDeliveryFee);
		this.attachCount = attachCount;
	}
	
	public void add(DirectProductAttachment attach) {
		this.directProductAttachments.add(attach);
	}
	
}
