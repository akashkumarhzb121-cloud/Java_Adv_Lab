package com.shopsphere.model;

import java.time.LocalDateTime;

public record Review(long id, long userId, String reviewerName, long productId,
                     int rating, String title, String body, LocalDateTime createdAt) {
    public long getId() { return id; }
    public long getUserId() { return userId; }
    public String getReviewerName() { return reviewerName; }
    public long getProductId() { return productId; }
    public int getRating() { return rating; }
    public String getTitle() { return title; }
    public String getBody() { return body; }
    public LocalDateTime getCreatedAt() { return createdAt; }
}
