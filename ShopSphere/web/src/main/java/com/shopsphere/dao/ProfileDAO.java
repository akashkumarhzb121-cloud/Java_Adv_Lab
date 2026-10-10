package com.shopsphere.dao;

import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ProfileDAO {
    public void update(long userId, String fullName, String phone) throws SQLException {
        if (fullName == null || fullName.trim().length() < 2 || fullName.trim().length() > 120
                || (phone != null && phone.length() > 30)) {
            throw new IllegalArgumentException("Enter a valid name and phone number.");
        }
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE users SET full_name=?,phone=? WHERE id=? AND active=TRUE")) {
            statement.setString(1, fullName.trim());
            statement.setString(2, phone == null || phone.isBlank() ? null : phone.trim());
            statement.setLong(3, userId);
            if (statement.executeUpdate() != 1) {
                throw new IllegalArgumentException("Profile is unavailable.");
            }
        }
    }
}
