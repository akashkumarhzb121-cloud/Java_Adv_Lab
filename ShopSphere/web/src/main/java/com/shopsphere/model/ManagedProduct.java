package com.shopsphere.model;

import java.math.BigDecimal;

public record ManagedProduct(long id, String name, String categoryName, String slug, BigDecimal price,
                             BigDecimal discountPercent, int stock, boolean active) {
    public long getId() { return id; }
    public String getName() { return name; }
    public String getCategoryName() { return categoryName; }
    public String getSlug() { return slug; }
    public BigDecimal getPrice() { return price; }
    public BigDecimal getDiscountPercent() { return discountPercent; }
    public int getStock() { return stock; }
    public boolean isActive() { return active; }
}
