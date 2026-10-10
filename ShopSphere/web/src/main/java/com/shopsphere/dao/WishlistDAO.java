package com.shopsphere.dao;

import com.shopsphere.model.Product;
import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {
    public List<Product> find(long userId) throws SQLException {
        String sql = """
                SELECT p.id,p.category_id,c.name AS category_name,p.name,p.slug,p.description,p.image_url,
                       p.price,p.discount_percent,p.stock,COALESCE(AVG(r.rating),0) AS rating,
                       COUNT(r.id) AS review_count
                FROM wishlist w JOIN products p ON p.id=w.product_id
                JOIN categories c ON c.id=p.category_id LEFT JOIN reviews r ON r.product_id=p.id
                WHERE w.user_id=? AND p.active=TRUE AND c.active=TRUE GROUP BY p.id,c.name ORDER BY w.created_at DESC
                """;
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, userId);
            try (ResultSet result = statement.executeQuery()) {
                List<Product> products = new ArrayList<>();
                while (result.next()) {
                    products.add(new Product(result.getLong("id"), result.getLong("category_id"),
                            result.getString("category_name"), result.getString("name"), result.getString("slug"),
                            result.getString("description"), result.getString("image_url"),
                            result.getBigDecimal("price"), result.getBigDecimal("discount_percent"),
                            result.getInt("stock"), result.getDouble("rating"), result.getInt("review_count")));
                }
                return products;
            }
        }
    }

    public void toggle(long userId, long productId) throws SQLException {
        try (Connection connection = Database.getConnection()) {
            try (PreparedStatement delete = connection.prepareStatement(
                    "DELETE FROM wishlist WHERE user_id=? AND product_id=?")) {
                delete.setLong(1, userId);
                delete.setLong(2, productId);
                if (delete.executeUpdate() > 0) {
                    return;
                }
            }
            try (PreparedStatement insert = connection.prepareStatement("""
                    INSERT INTO wishlist(user_id,product_id)
                    SELECT ?,id FROM products WHERE id=? AND active=TRUE
                    """)) {
                insert.setLong(1, userId);
                insert.setLong(2, productId);
                if (insert.executeUpdate() == 0) {
                    throw new IllegalArgumentException("Product is unavailable.");
                }
            }
        }
    }
}
