package com.shopsphere.model;

import java.math.BigDecimal;

public record CartItem(Product product, int quantity) {
    public BigDecimal lineTotal() {
        return product.salePrice().multiply(BigDecimal.valueOf(quantity));
    }

    public Product getProduct() { return product; }
    public int getQuantity() { return quantity; }
    public BigDecimal getLineTotal() { return lineTotal(); }
}
