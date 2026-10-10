package com.shopsphere.model;

import java.time.LocalDateTime;

public record CouponUsage(long couponId, long userId, long orderId, LocalDateTime usedAt) {
}
