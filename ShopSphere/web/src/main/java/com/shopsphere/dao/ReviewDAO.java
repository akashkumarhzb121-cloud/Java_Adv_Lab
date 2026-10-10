package com.shopsphere.dao;

import com.shopsphere.util.Database;
import com.shopsphere.model.Review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ReviewDAO {
    public java.util.List<Review> findForProduct(long productId) throws SQLException {
        String sql = """
                SELECT r.id,r.user_id,u.full_name,r.product_id,r.rating,r.title,r.body,r.created_at
                FROM reviews r JOIN users u ON u.id=r.user_id WHERE r.product_id=?
                ORDER BY r.created_at DESC
                """;
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, productId);
            try (java.sql.ResultSet result = statement.executeQuery()) {
                java.util.List<Review> reviews = new java.util.ArrayList<>();
                while (result.next()) {
                    reviews.add(new Review(result.getLong("id"), result.getLong("user_id"),
                            result.getString("full_name"), result.getLong("product_id"),
                            result.getInt("rating"), result.getString("title"), result.getString("body"),
                            result.getTimestamp("created_at").toLocalDateTime()));
                }
                return reviews;
            }
        }
    }

    public void save(long userId, long productId, int rating, String title, String body) throws SQLException {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be from 1 to 5.");
        }
        String sql = """
                INSERT INTO reviews(user_id,product_id,rating,title,body)
                SELECT ?,p.id,?,?,? FROM products p
                WHERE p.id=? AND p.active=TRUE
                  AND EXISTS (SELECT 1 FROM order_items i JOIN orders o ON o.id=i.order_id
                              WHERE i.product_id=p.id AND o.user_id=? AND o.status<>'CANCELLED')
                ON DUPLICATE KEY UPDATE rating=VALUES(rating),title=VALUES(title),body=VALUES(body)
                """;
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, userId);
            statement.setInt(2, rating);
            statement.setString(3, title);
            statement.setString(4, body);
            statement.setLong(5, productId);
            statement.setLong(6, userId);
            if (statement.executeUpdate() == 0) {
                throw new IllegalArgumentException("Product is unavailable.");
            }
        }
    }
}
