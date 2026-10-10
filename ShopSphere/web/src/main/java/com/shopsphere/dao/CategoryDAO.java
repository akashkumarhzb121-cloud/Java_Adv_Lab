package com.shopsphere.dao;

import com.shopsphere.model.Category;
import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<Category> findAll() throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT id,name,slug,active FROM categories ORDER BY name");
             ResultSet result = statement.executeQuery()) {
            List<Category> categories = new ArrayList<>();
            while (result.next()) {
                categories.add(new Category(result.getLong("id"), result.getString("name"),
                        result.getString("slug"), result.getBoolean("active")));
            }
            return categories;
        }
    }

    public void add(String name, String description) throws SQLException {
        String normalized = name.trim();
        String slug = normalized.toLowerCase(java.util.Locale.ROOT).replaceAll("[^a-z0-9]+", "-")
                .replaceAll("(^-|-$)", "");
        if (normalized.isBlank() || normalized.length() > 100 || slug.isBlank()
                || (description != null && description.length() > 500)) {
            throw new IllegalArgumentException("Enter a valid category name and description.");
        }

        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "INSERT INTO categories(name,slug,description) VALUES(?,?,?)")) {
            statement.setString(1, normalized);
            statement.setString(2, slug);
            statement.setString(3, description);
            statement.executeUpdate();
        }
    }

    public void setActive(long categoryId, boolean active) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE categories SET active=? WHERE id=?")) {
            statement.setBoolean(1, active);
            statement.setLong(2, categoryId);
            if (statement.executeUpdate() == 0) {
                throw new IllegalArgumentException("Category not found.");
            }
        }
    }
}
