package com.shopsphere.admin.controller;

import com.shopsphere.admin.dao.InventoryDao;

import java.sql.SQLException;

public final class InventoryController extends EntityController {
    private final InventoryDao inventoryDao;

    public InventoryController(InventoryDao inventoryDao) {
        super(inventoryDao);
        this.inventoryDao = inventoryDao;
    }

    public void restock(Object productId, int amount) throws SQLException {
        inventoryDao.restock(productId, amount);
    }
}
