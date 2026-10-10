package com.shopsphere.dao;

import com.shopsphere.model.CartItem;
import com.shopsphere.model.Product;
import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    public List<CartItem> findForUser(long userId) throws SQLException {
        String sql = """
                SELECT p.id, p.category_id, c.name AS category_name, p.name, p.slug, p.description,
                       p.image_url, p.price, p.discount_percent, p.stock,
                       COALESCE(AVG(r.rating),0) AS rating, COUNT(r.id) AS review_count, ca.quantity,
                       MAX(ca.updated_at) AS cart_updated_at
                FROM cart ca JOIN products p ON p.id=ca.product_id
                JOIN categories c ON c.id=p.category_id
                LEFT JOIN reviews r ON r.product_id=p.id
                WHERE ca.user_id=? GROUP BY p.id,c.name,ca.quantity ORDER BY cart_updated_at DESC
                """;
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, userId);
            try (ResultSet result = statement.executeQuery()) {
                List<CartItem> items = new ArrayList<>();
                while (result.next()) {
                    Product product = new Product(result.getLong("id"), result.getLong("category_id"),
                            result.getString("category_name"), result.getString("name"),
                            result.getString("slug"), result.getString("description"),
                            result.getString("image_url"), result.getBigDecimal("price"),
                            result.getBigDecimal("discount_percent"), result.getInt("stock"),
                            result.getDouble("rating"), result.getInt("review_count"));
                    items.add(new CartItem(product, result.getInt("quantity")));
                }
                return items;
            }
        }
    }

    public int countForUser(long userId) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT COALESCE(SUM(quantity),0) FROM cart WHERE user_id=?")) {
            statement.setLong(1, userId);
            try (ResultSet result = statement.executeQuery()) {
                result.next();
                return result.getInt(1);
            }
        }
    }

    public void add(long userId, long productId, int quantity) throws SQLException {
        try (Connection connection = Database.getConnection()) {
            connection.setAutoCommit(false);
            try {
                try (PreparedStatement stockCheck = connection.prepareStatement(
                        "SELECT stock FROM products WHERE id=? AND active=TRUE FOR UPDATE")) {
                    stockCheck.setLong(1, productId);
                    try (ResultSet result = stockCheck.executeQuery()) {
                        if (!result.next() || result.getInt("stock") < quantity) {
                            throw new IllegalArgumentException("This quantity is not currently available.");
                        }
                    }
                }
                try (PreparedStatement upsert = connection.prepareStatement("""
                        INSERT INTO cart(user_id,product_id,quantity) VALUES(?,?,?)
                        ON DUPLICATE KEY UPDATE quantity=quantity+VALUES(quantity)
                        """)) {
                    upsert.setLong(1, userId);
                    upsert.setLong(2, productId);
                    upsert.setInt(3, quantity);
                    upsert.executeUpdate();
                }
                try (PreparedStatement check = connection.prepareStatement("""
                        SELECT ca.quantity,p.stock FROM cart ca JOIN products p ON p.id=ca.product_id
                        WHERE ca.user_id=? AND ca.product_id=?
                        """)) {
                    check.setLong(1, userId);
                    check.setLong(2, productId);
                    try (ResultSet result = check.executeQuery()) {
                        if (result.next() && result.getInt("quantity") > result.getInt("stock")) {
                            throw new IllegalArgumentException("The cart quantity exceeds available stock.");
                        }
                    }
                }
                connection.commit();
            } catch (SQLException | RuntimeException exception) {
                connection.rollback();
                throw exception;
            }
        }
    }

    public void setQuantity(long userId, long productId, int quantity) throws SQLException {
        if (quantity < 1 || quantity > 99) {
            throw new IllegalArgumentException("Quantity must be between 1 and 99.");
        }
        String sql = """
                UPDATE cart ca JOIN products p ON p.id=ca.product_id
                JOIN categories c ON c.id=p.category_id
                SET ca.quantity=? WHERE ca.user_id=? AND ca.product_id=? AND p.stock>=?
                  AND p.active=TRUE AND c.active=TRUE
                """;
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, quantity);
            statement.setLong(2, userId);
            statement.setLong(3, productId);
            statement.setInt(4, quantity);
            if (statement.executeUpdate() == 0) {
                throw new IllegalArgumentException("Item not found or requested quantity exceeds stock.");
            }
        }
    }

    public void remove(long userId, long productId) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "DELETE FROM cart WHERE user_id=? AND product_id=?")) {
            statement.setLong(1, userId);
            statement.setLong(2, productId);
            statement.executeUpdate();
        }
    }
}
