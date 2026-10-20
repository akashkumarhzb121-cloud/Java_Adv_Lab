package com.shopsphere.model;

import java.math.BigDecimal;

public record OrderItem(long productId, String productName, BigDecimal unitPrice, int quantity) {
    public BigDecimal lineTotal() { return unitPrice.multiply(BigDecimal.valueOf(quantity)); }
    public long getProductId() { return productId; }
    public String getProductName() { return productName; }
    public BigDecimal getUnitPrice() { return unitPrice; }
    public int getQuantity() { return quantity; }
    public BigDecimal getLineTotal() { return lineTotal(); }
}
