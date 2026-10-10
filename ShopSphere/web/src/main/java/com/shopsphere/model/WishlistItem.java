package com.shopsphere.model;

import java.time.LocalDateTime;

public record WishlistItem(Product product, LocalDateTime addedAt) {
}
