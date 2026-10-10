package com.shopsphere.rmi;

import java.io.Serial;
import java.io.Serializable;

public record InventoryItem(String sku, String name, int quantity) implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
}
