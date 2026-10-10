package com.shopsphere.model;

import java.math.BigDecimal;

public record Product(long id, long categoryId, String categoryName, String name, String slug,
                      String description, String imageUrl, BigDecimal price,
                      BigDecimal discountPercent, int stock, double rating, int reviewCount) {
    public BigDecimal salePrice() {
        return price.multiply(BigDecimal.ONE.subtract(discountPercent
                .divide(new BigDecimal("100")))).setScale(2, java.math.RoundingMode.HALF_UP);
    }

    public long getId() { return id; }
    public long getCategoryId() { return categoryId; }
    public String getCategoryName() { return categoryName; }
    public String getName() { return name; }
    public String getSlug() { return slug; }
    public String getDescription() { return description; }
    public String getImageUrl() { return imageUrl; }
    public BigDecimal getPrice() { return price; }
    public BigDecimal getDiscountPercent() { return discountPercent; }
    public int getStock() { return stock; }
    public double getRating() { return rating; }
    public int getReviewCount() { return reviewCount; }
    public BigDecimal getSalePrice() { return salePrice(); }
}
