package com.shopsphere.network;

import java.io.Serial;
import java.io.Serializable;

public record InventoryItem(String sku, String name, int quantity) implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    public InventoryItem {
        if (sku == null || sku.isBlank() || name == null || name.isBlank() || quantity < 0) {
            throw new IllegalArgumentException("SKU/name must be non-empty and quantity non-negative");
        }
    }
}
