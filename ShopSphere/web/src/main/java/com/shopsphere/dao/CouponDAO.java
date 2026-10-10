package com.shopsphere.dao;

import com.shopsphere.model.Coupon;
import com.shopsphere.util.Database;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CouponDAO {
    public List<Coupon> findAll() throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT id,code,discount_percent,minimum_order,active FROM coupons ORDER BY expires_at DESC");
             ResultSet result = statement.executeQuery()) {
            List<Coupon> coupons = new ArrayList<>();
            while (result.next()) {
                coupons.add(new Coupon(result.getLong("id"), result.getString("code"),
                        result.getBigDecimal("discount_percent"), result.getBigDecimal("minimum_order"),
                        result.getBoolean("active")));
            }
            return coupons;
        }
    }

    public void add(String code, BigDecimal percent, BigDecimal minimumOrder) throws SQLException {
        String normalizedCode = code == null ? "" : code.trim().toUpperCase(java.util.Locale.ROOT);
        if (!normalizedCode.matches("[A-Z0-9_-]{3,40}") || percent == null
                || percent.compareTo(BigDecimal.ZERO) <= 0 || percent.compareTo(new BigDecimal("100")) > 0
                || minimumOrder == null || minimumOrder.signum() < 0) {
            throw new IllegalArgumentException("Enter a valid coupon code, percentage and minimum order.");
        }

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement("""
                     INSERT INTO coupons(code,discount_percent,minimum_order,starts_at,expires_at,active)
                     VALUES(?,?,?,CURRENT_TIMESTAMP,DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 YEAR),TRUE)
                     """)) {
            statement.setString(1, normalizedCode);
            statement.setBigDecimal(2, percent);
            statement.setBigDecimal(3, minimumOrder);
            statement.executeUpdate();
        }
    }

    public void setActive(long couponId, boolean active) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE coupons SET active=? WHERE id=?")) {
            statement.setBoolean(1, active);
            statement.setLong(2, couponId);
            if (statement.executeUpdate() == 0) {
                throw new IllegalArgumentException("Coupon not found.");
            }
        }
    }
}
