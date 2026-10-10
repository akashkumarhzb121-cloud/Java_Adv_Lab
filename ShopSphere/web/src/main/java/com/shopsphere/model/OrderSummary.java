package com.shopsphere.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record OrderSummary(long id, String status, BigDecimal subtotal, BigDecimal discount,
                           BigDecimal total, LocalDateTime placedAt) {
    public long getId() { return id; }
    public String getStatus() { return status; }
    public BigDecimal getSubtotal() { return subtotal; }
    public BigDecimal getDiscount() { return discount; }
    public BigDecimal getTotal() { return total; }
    public LocalDateTime getPlacedAt() { return placedAt; }
}
