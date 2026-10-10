package com.shopsphere.dao;

import com.shopsphere.model.User;
import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

public class UserDAO {
    public Optional<AuthenticatedUser> findByEmail(String email) throws SQLException {
        String sql = "SELECT id, full_name, email, password_hash, role, phone FROM users WHERE email=? AND active=TRUE";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next()) {
                    return Optional.empty();
                }
                User user = new User(result.getLong("id"), result.getString("full_name"),
                        result.getString("email"), result.getString("role"), result.getString("phone"));
                return Optional.of(new AuthenticatedUser(user, result.getString("password_hash")));
            }
        }
    }

    public User create(String fullName, String email, String passwordHash) throws SQLException {
        String sql = "INSERT INTO users(full_name,email,password_hash) VALUES(?,?,?)";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setString(3, passwordHash);
            statement.executeUpdate();
            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (!keys.next()) {
                    throw new SQLException("Registration succeeded without returning a user id.");
                }
                return new User(keys.getLong(1), fullName, email, "CUSTOMER", null);
            }
        }
    }

    public record AuthenticatedUser(User user, String passwordHash) {
    }
}
