package com.shopsphere.dao;

import com.shopsphere.model.Address;
import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {
    public List<Address> findForUser(long userId) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement("""
                     SELECT id,label,line1,line2,city,state,postal_code,country
                     FROM addresses WHERE user_id=? ORDER BY is_default DESC,id DESC
                     """)) {
            statement.setLong(1, userId);
            try (ResultSet result = statement.executeQuery()) {
                List<Address> addresses = new ArrayList<>();
                while (result.next()) {
                    addresses.add(new Address(result.getLong("id"), result.getString("label"),
                            result.getString("line1"), result.getString("line2"),
                            result.getString("city"), result.getString("state"),
                            result.getString("postal_code"), result.getString("country")));
                }
                return addresses;
            }
        }
    }

    public void add(long userId, String label, String line1, String line2, String city,
                    String state, String postalCode, String country) throws SQLException {
        validate(label, "Label", 40);
        validate(line1, "Address", 180);
        validate(city, "City", 100);
        validate(state, "State", 100);
        validate(country, "Country", 80);
        if (postalCode == null || !postalCode.matches("[A-Za-z0-9 -]{3,20}")
                || (line2 != null && line2.length() > 180)) {
            throw new IllegalArgumentException("Enter a valid postal code and address line.");
        }
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement("""
                     INSERT INTO addresses(user_id,label,line1,line2,city,state,postal_code,country)
                     VALUES(?,?,?,?,?,?,?,?)
                     """)) {
            statement.setLong(1, userId);
            statement.setString(2, label.trim());
            statement.setString(3, line1.trim());
            statement.setString(4, line2 == null ? null : line2.trim());
            statement.setString(5, city.trim());
            statement.setString(6, state.trim());
            statement.setString(7, postalCode.trim());
            statement.setString(8, country.trim());
            statement.executeUpdate();
        }
    }

    public void delete(long userId, long addressId) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "DELETE FROM addresses WHERE id=? AND user_id=?")) {
            statement.setLong(1, addressId);
            statement.setLong(2, userId);
            if (statement.executeUpdate() == 0) {
                throw new IllegalArgumentException("Address not found.");
            }
        }
    }

    private static void validate(String value, String label, int limit) {
        if (value == null || value.isBlank() || value.trim().length() > limit) {
            throw new IllegalArgumentException(label + " is required and must be at most " + limit + " characters.");
        }
    }
}
