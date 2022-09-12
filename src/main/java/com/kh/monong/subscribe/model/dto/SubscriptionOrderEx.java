package com.kh.monong.subscribe.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class SubscriptionOrderEx extends SubscriptionOrder {
	private Subscription subscription;

	public SubscriptionOrderEx(String sOrderNo, @NonNull String sNo, int sTimes, int sPrice, LocalDateTime sOrderDate,
			String sOrderStatus) {
		super(sOrderNo, sNo, sTimes, sPrice, sOrderDate, sOrderStatus);
	}
}
