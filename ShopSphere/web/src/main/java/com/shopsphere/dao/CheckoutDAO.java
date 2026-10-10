package com.shopsphere.dao;

import com.shopsphere.model.OrderSummary;
import com.shopsphere.util.Database;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.OptionalLong;
import java.util.UUID;

public class CheckoutDAO {
    public long placeOrder(long userId, String addressLabel, String line1, String line2,
                           String city, String state, String postalCode, String country,
                           String couponCode, String paymentMethod) throws SQLException {
        try (Connection connection = Database.getConnection()) {
            connection.setAutoCommit(false);
            try {
                long addressId = saveAddress(connection, userId, addressLabel, line1, line2,
                        city, state, postalCode, country);
                List<LockedItem> items = lockCart(connection, userId);
                if (items.isEmpty()) {
                    throw new IllegalArgumentException("Your cart is empty.");
                }
                BigDecimal subtotal = BigDecimal.ZERO;
                for (LockedItem item : items) {
                    subtotal = subtotal.add(item.unitPrice.multiply(BigDecimal.valueOf(item.quantity)));
                }
                Optional<Coupon> coupon = findCoupon(connection, userId, couponCode, subtotal);
                BigDecimal discount = BigDecimal.ZERO;
                if (coupon.isPresent()) {
                    discount = subtotal.multiply(coupon.get().percent)
                            .divide(new BigDecimal("100"), 2, java.math.RoundingMode.HALF_UP);
                }
                BigDecimal total = subtotal.subtract(discount);
                OptionalLong couponId = coupon.isPresent()
                        ? OptionalLong.of(coupon.get().id) : OptionalLong.empty();
                long orderId = insertOrder(connection, userId, addressId, subtotal, discount, total,
                        couponId);
                insertItems(connection, orderId, items);
                decrementStock(connection, items);
                insertPayment(connection, orderId, paymentMethod, total);
                if (coupon.isPresent()) {
                    recordCouponUse(connection, coupon.get().id, userId, orderId);
                }
                try (PreparedStatement clearCart = connection.prepareStatement("DELETE FROM cart WHERE user_id=?")) {
                    clearCart.setLong(1, userId);
                    clearCart.executeUpdate();
                }
                connection.commit();
                return orderId;
            } catch (SQLException | RuntimeException exception) {
                connection.rollback();
                throw exception;
            }
        }
    }

    private static long saveAddress(Connection connection, long userId, String label, String line1,
                                    String line2, String city, String state, String postalCode,
                                    String country) throws SQLException {
        String sql = """
                INSERT INTO addresses(user_id,label,line1,line2,city,state,postal_code,country)
                VALUES(?,?,?,?,?,?,?,?)
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setLong(1, userId);
            statement.setString(2, label);
            statement.setString(3, line1);
            statement.setString(4, line2);
            statement.setString(5, city);
            statement.setString(6, state);
            statement.setString(7, postalCode);
            statement.setString(8, country);
            statement.executeUpdate();
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (!keys.next()) {
                    throw new SQLException("Could not save the delivery address.");
                }
                return keys.getLong(1);
            }
        }
    }

    private static List<LockedItem> lockCart(Connection connection, long userId) throws SQLException {
        try (PreparedStatement availability = connection.prepareStatement("""
                SELECT COUNT(*) FROM cart ca LEFT JOIN products p ON p.id=ca.product_id
                LEFT JOIN categories c ON c.id=p.category_id
                WHERE ca.user_id=? AND (p.id IS NULL OR p.active=FALSE OR c.active=FALSE)
                """)) {
            availability.setLong(1, userId);
            try (ResultSet result = availability.executeQuery()) {
                result.next();
                if (result.getLong(1) > 0) {
                    throw new IllegalArgumentException("Remove unavailable products from your cart before checkout.");
                }
            }
        }
        String sql = """
                SELECT p.id,p.name,p.price,p.discount_percent,p.stock,ca.quantity
                FROM cart ca JOIN products p ON p.id=ca.product_id
                JOIN categories c ON c.id=p.category_id
                WHERE ca.user_id=? AND p.active=TRUE AND c.active=TRUE FOR UPDATE
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, userId);
            try (ResultSet result = statement.executeQuery()) {
                List<LockedItem> items = new ArrayList<>();
                while (result.next()) {
                    int quantity = result.getInt("quantity");
                    int stock = result.getInt("stock");
                    if (quantity > stock) {
                        throw new IllegalArgumentException(result.getString("name")
                                + " no longer has the requested quantity in stock.");
                    }
                    BigDecimal price = result.getBigDecimal("price");
                    BigDecimal discount = result.getBigDecimal("discount_percent");
                    BigDecimal salePrice = price.multiply(BigDecimal.ONE.subtract(
                            discount.divide(new BigDecimal("100"))))
                            .setScale(2, java.math.RoundingMode.HALF_UP);
                    items.add(new LockedItem(result.getLong("id"), result.getString("name"),
                            salePrice, quantity));
                }
                return items;
            }
        }
    }

    private static Optional<Coupon> findCoupon(Connection connection, long userId, String code,
                                               BigDecimal subtotal) throws SQLException {
        if (code == null || code.isBlank()) {
            return Optional.empty();
        }
        String sql = """
                SELECT c.id,c.discount_percent,c.minimum_order,c.usage_limit,
                       (SELECT COUNT(*) FROM coupon_usage u WHERE u.coupon_id=c.id) AS uses,
                       EXISTS(SELECT 1 FROM coupon_usage u WHERE u.coupon_id=c.id AND u.user_id=?) AS used_by_user
                FROM coupons c WHERE c.code=? AND c.active=TRUE
                  AND c.starts_at<=CURRENT_TIMESTAMP AND c.expires_at>=CURRENT_TIMESTAMP FOR UPDATE
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, userId);
            statement.setString(2, code.trim().toUpperCase(java.util.Locale.ROOT));
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next()) {
                    throw new IllegalArgumentException("That coupon is invalid or expired.");
                }
                Integer limit = (Integer) result.getObject("usage_limit");
                if (result.getBigDecimal("minimum_order").compareTo(subtotal) > 0
                        || result.getBoolean("used_by_user")
                        || (limit != null && result.getInt("uses") >= limit)) {
                    throw new IllegalArgumentException("That coupon is not eligible for this order.");
                }
                return Optional.of(new Coupon(result.getLong("id"), result.getBigDecimal("discount_percent")));
            }
        }
    }

    private static long insertOrder(Connection connection, long userId, long addressId, BigDecimal subtotal,
                                    BigDecimal discount, BigDecimal total, OptionalLong couponId) throws SQLException {
        String sql = """
                INSERT INTO orders(user_id,address_id,subtotal,discount,total,coupon_id)
                VALUES(?,?,?,?,?,?)
                """;
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setLong(1, userId);
            statement.setLong(2, addressId);
            statement.setBigDecimal(3, subtotal);
            statement.setBigDecimal(4, discount);
            statement.setBigDecimal(5, total);
            if (couponId.isEmpty()) {
                statement.setNull(6, java.sql.Types.BIGINT);
            } else {
                statement.setLong(6, couponId.getAsLong());
            }
            statement.executeUpdate();
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (!keys.next()) {
                    throw new SQLException("Order creation did not return an id.");
                }
                return keys.getLong(1);
            }
        }
    }

    private static void insertItems(Connection connection, long orderId, List<LockedItem> items)
            throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement("""
                INSERT INTO order_items(order_id,product_id,product_name,unit_price,quantity)
                VALUES(?,?,?,?,?)
                """)) {
            for (LockedItem item : items) {
                statement.setLong(1, orderId);
                statement.setLong(2, item.productId);
                statement.setString(3, item.name);
                statement.setBigDecimal(4, item.unitPrice);
                statement.setInt(5, item.quantity);
                statement.addBatch();
            }
            statement.executeBatch();
        }
    }

    private static void decrementStock(Connection connection, List<LockedItem> items) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(
                "UPDATE products SET stock=stock-? WHERE id=? AND stock>=?")) {
            for (LockedItem item : items) {
                statement.setInt(1, item.quantity);
                statement.setLong(2, item.productId);
                statement.setInt(3, item.quantity);
                if (statement.executeUpdate() != 1) {
                    throw new SQLException("Inventory changed during checkout; retry the order.");
                }
            }
        }
    }

    private static void insertPayment(Connection connection, long orderId, String method, BigDecimal amount)
            throws SQLException {
        boolean cash = "CASH_ON_DELIVERY".equals(method);
        try (PreparedStatement statement = connection.prepareStatement("""
                INSERT INTO payments(order_id,method,status,amount,transaction_ref,paid_at)
                VALUES(?,?,?,?,?,?)
                """)) {
            statement.setLong(1, orderId);
            statement.setString(2, cash ? "CASH_ON_DELIVERY" : "MOCK_CARD");
            statement.setString(3, cash ? "PENDING" : "PAID");
            statement.setBigDecimal(4, amount);
            statement.setString(5, "SS-" + UUID.randomUUID());
            if (cash) {
                statement.setNull(6, java.sql.Types.TIMESTAMP);
            } else {
                statement.setTimestamp(6, java.sql.Timestamp.valueOf(LocalDateTime.now()));
            }
            statement.executeUpdate();
        }
    }

    private static void recordCouponUse(Connection connection, long couponId, long userId, long orderId)
            throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO coupon_usage(coupon_id,user_id,order_id) VALUES(?,?,?)")) {
            statement.setLong(1, couponId);
            statement.setLong(2, userId);
            statement.setLong(3, orderId);
            statement.executeUpdate();
        }
    }

    private record LockedItem(long productId, String name, BigDecimal unitPrice, int quantity) {
    }

    private record Coupon(long id, BigDecimal percent) {
    }

    public List<OrderSummary> findOrders(long userId) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement("""
                     SELECT id,status,subtotal,discount,total,placed_at FROM orders
                     WHERE user_id=? ORDER BY placed_at DESC
                     """)) {
            statement.setLong(1, userId);
            try (ResultSet result = statement.executeQuery()) {
                List<OrderSummary> orders = new ArrayList<>();
                while (result.next()) {
                    orders.add(new OrderSummary(result.getLong("id"), result.getString("status"),
                            result.getBigDecimal("subtotal"), result.getBigDecimal("discount"),
                            result.getBigDecimal("total"), result.getTimestamp("placed_at").toLocalDateTime()));
                }
                return orders;
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
}
