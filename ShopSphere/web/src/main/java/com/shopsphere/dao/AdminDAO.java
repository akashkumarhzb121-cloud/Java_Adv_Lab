package com.shopsphere.dao;

import com.shopsphere.model.User;
import com.shopsphere.model.CustomerAccount;
import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AdminDAO {
    public Map<String, Object> dashboard() throws SQLException {
        try (Connection connection = Database.getConnection()) {
            long customers = scalar(connection, "SELECT COUNT(*) FROM users WHERE role='CUSTOMER' AND active=TRUE");
            long products = scalar(connection, "SELECT COUNT(*) FROM products WHERE active=TRUE");
            long orders = scalar(connection, "SELECT COUNT(*) FROM orders");
            java.math.BigDecimal sales;
            try (PreparedStatement statement = connection.prepareStatement(
                    "SELECT COALESCE(SUM(total),0) FROM orders WHERE status<>'CANCELLED'");
                 ResultSet result = statement.executeQuery()) {
                result.next();
                sales = result.getBigDecimal(1);
            }
            long lowStock = scalar(connection, "SELECT COUNT(*) FROM products WHERE active=TRUE AND stock<=5");
            return Map.of("customers", customers, "products", products, "orders", orders,
                    "sales", sales, "lowStock", lowStock);
        }
    }

    public List<CustomerAccount> customers() throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement("""
                     SELECT id,full_name,email,role,phone,active FROM users WHERE role='CUSTOMER' ORDER BY created_at DESC
                     """);
             ResultSet result = statement.executeQuery()) {
            List<CustomerAccount> users = new ArrayList<>();
            while (result.next()) {
                users.add(new CustomerAccount(new User(result.getLong("id"), result.getString("full_name"),
                        result.getString("email"), result.getString("role"), result.getString("phone")),
                        result.getBoolean("active")));
            }
            return users;
        }
    }

    public void setCustomerActive(long userId, boolean active) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE users SET active=? WHERE id=? AND role='CUSTOMER'")) {
            statement.setBoolean(1, active);
            statement.setLong(2, userId);
            if (statement.executeUpdate() == 0) {
                throw new IllegalArgumentException("Customer not found.");
            }
        }
    }

    private static long scalar(Connection connection, String sql) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            result.next();
            return result.getLong(1);
        }
    }
}
