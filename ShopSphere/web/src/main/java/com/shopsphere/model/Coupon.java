package com.shopsphere.model;

import java.math.BigDecimal;

public record Coupon(long id, String code, BigDecimal discountPercent, BigDecimal minimumOrder, boolean active) {
    public long getId() { return id; }
    public String getCode() { return code; }
    public BigDecimal getDiscountPercent() { return discountPercent; }
    public BigDecimal getMinimumOrder() { return minimumOrder; }
    public boolean isActive() { return active; }
}
