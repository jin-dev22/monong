package com.kh.monong.common.faq.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Faq {
	private int faqNo;
	private String faqType;
	private String faqTitle;
	private String faqContent;
}
