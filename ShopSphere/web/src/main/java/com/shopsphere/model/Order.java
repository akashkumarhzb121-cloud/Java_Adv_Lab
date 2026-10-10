package com.shopsphere.model;

import java.math.BigDecimal;
import java.util.List;

public record Order(long id, long userId, long addressId, String status, BigDecimal subtotal,
                    BigDecimal discount, BigDecimal total, List<OrderItem> items) {
    public Order {
        items = List.copyOf(items);
    }

    public long getId() { return id; }
    public long getUserId() { return userId; }
    public long getAddressId() { return addressId; }
    public String getStatus() { return status; }
    public BigDecimal getSubtotal() { return subtotal; }
    public BigDecimal getDiscount() { return discount; }
    public BigDecimal getTotal() { return total; }
    public List<OrderItem> getItems() { return items; }
}
