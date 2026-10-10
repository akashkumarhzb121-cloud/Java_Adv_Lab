package com.shopsphere.admin.dao;

import com.shopsphere.admin.DbConfig;
import com.shopsphere.admin.EntitySpec;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public final class InventoryDao extends JdbcEntityDao {
    public InventoryDao() {
        super(new EntitySpec("Inventory", "products", "id",
                List.of("id", "name", "description", "price", "stock", "category_id")));
    }

    public void restock(Object productId, int amount) throws SQLException {
        if (amount <= 0) throw new IllegalArgumentException("Restock amount must be positive");
        String sql = "UPDATE products SET stock = stock + ? WHERE id = ?";
        try (Connection connection = DbConfig.openConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, amount);
            statement.setObject(2, productId);
            if (statement.executeUpdate() == 0) throw new SQLException("Product not found");
        }
    }
}
