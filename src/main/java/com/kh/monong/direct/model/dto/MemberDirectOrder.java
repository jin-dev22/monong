package com.kh.monong.direct.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberDirectOrder {
	private String dOptionNo;
	private String dOrderNo;
	private int dOptionCount;
	private String dProductNo;
}
