package com.shopsphere.dao;

import com.shopsphere.model.OrderSummary;
import com.shopsphere.model.OrderItem;
import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public List<OrderSummary> findForCustomer(long userId) throws SQLException {
        String sql = "SELECT id,status,subtotal,discount,total,placed_at FROM orders WHERE user_id=? ORDER BY placed_at DESC";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, userId);
            try (ResultSet result = statement.executeQuery()) {
                List<OrderSummary> orders = new ArrayList<>();
                while (result.next()) {
                    orders.add(map(result));
                }
                return orders;
            }
        }
    }

    public List<OrderSummary> findAll() throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT id,status,subtotal,discount,total,placed_at FROM orders ORDER BY placed_at DESC");
             ResultSet result = statement.executeQuery()) {
            List<OrderSummary> orders = new ArrayList<>();
            while (result.next()) {
                orders.add(map(result));
            }
            return orders;
        }
    }

    public boolean updateStatus(long id, String status) throws SQLException {
        try (Connection connection = Database.getConnection()) {
            connection.setAutoCommit(false);
            try {
                String currentStatus;
                try (PreparedStatement lockOrder = connection.prepareStatement(
                        "SELECT status FROM orders WHERE id=? FOR UPDATE")) {
                    lockOrder.setLong(1, id);
                    try (ResultSet result = lockOrder.executeQuery()) {
                        if (!result.next()) {
                            connection.rollback();
                            return false;
                        }
                        currentStatus = result.getString("status");
                    }
                }
                if (currentStatus.equals(status)) {
                    connection.commit();
                    return true;
                }
                boolean allowed = switch (currentStatus) {
                    case "PLACED" -> "PROCESSING".equals(status) || "CANCELLED".equals(status);
                    case "PROCESSING" -> "SHIPPED".equals(status) || "CANCELLED".equals(status);
                    case "SHIPPED" -> "DELIVERED".equals(status);
                    default -> false;
                };
                if (!allowed) {
                    connection.rollback();
                    return false;
                }
                if ("CANCELLED".equals(status)) {
                    restoreInventory(connection, id);
                    try (PreparedStatement refund = connection.prepareStatement("""
                            UPDATE payments SET status='REFUNDED'
                            WHERE order_id=? AND status='PAID'
                            """)) {
                        refund.setLong(1, id);
                        refund.executeUpdate();
                    }
                }
                try (PreparedStatement update = connection.prepareStatement(
                        "UPDATE orders SET status=? WHERE id=?")) {
                    update.setString(1, status);
                    update.setLong(2, id);
                    update.executeUpdate();
                }
                connection.commit();
                return true;
            } catch (SQLException | RuntimeException exception) {
                connection.rollback();
                throw exception;
            }
        }
    }

    private static void restoreInventory(Connection connection, long orderId) throws SQLException {
        try (PreparedStatement items = connection.prepareStatement(
                "SELECT product_id,quantity FROM order_items WHERE order_id=?")) {
            items.setLong(1, orderId);
            try (ResultSet result = items.executeQuery();
                 PreparedStatement restore = connection.prepareStatement(
                         "UPDATE products SET stock=stock+? WHERE id=?")) {
                while (result.next()) {
                    restore.setInt(1, result.getInt("quantity"));
                    restore.setLong(2, result.getLong("product_id"));
                    restore.addBatch();
                }
                restore.executeBatch();
            }
        }
    }

    public boolean ownsOrder(long orderId, long userId) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT 1 FROM orders WHERE id=? AND user_id=?")) {
            statement.setLong(1, orderId);
            statement.setLong(2, userId);
            try (ResultSet result = statement.executeQuery()) {
                return result.next();
            }
        }
    }

    public List<OrderItem> findItems(long orderId, long userId) throws SQLException {
        String sql = """
                SELECT i.product_id,i.product_name,i.unit_price,i.quantity
                FROM order_items i JOIN orders o ON o.id=i.order_id
                WHERE i.order_id=? AND o.user_id=? ORDER BY i.id
                """;
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, orderId);
            statement.setLong(2, userId);
            try (ResultSet result = statement.executeQuery()) {
                List<OrderItem> items = new ArrayList<>();
                while (result.next()) {
                    items.add(new OrderItem(result.getLong("product_id"), result.getString("product_name"),
                            result.getBigDecimal("unit_price"), result.getInt("quantity")));
                }
                return items;
            }
        }
    }

    private static OrderSummary map(ResultSet result) throws SQLException {
        return new OrderSummary(result.getLong("id"), result.getString("status"),
                result.getBigDecimal("subtotal"), result.getBigDecimal("discount"),
                result.getBigDecimal("total"), result.getTimestamp("placed_at").toLocalDateTime());
    }
}
