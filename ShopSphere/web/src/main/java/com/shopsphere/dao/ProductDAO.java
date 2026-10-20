package com.shopsphere.dao;

import com.shopsphere.model.Category;
import com.shopsphere.model.Product;
import com.shopsphere.model.ManagedProduct;
import com.shopsphere.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductDAO {
    private static final String SELECT_PRODUCTS = """
            SELECT p.id, p.category_id, c.name AS category_name, p.name, p.slug, p.description,
                   p.image_url, p.price, p.discount_percent, p.stock,
                   COALESCE(AVG(r.rating), 0) AS rating, COUNT(r.id) AS review_count
            FROM products p
            JOIN categories c ON c.id = p.category_id
            LEFT JOIN reviews r ON r.product_id = p.id
            """;

    public List<Product> findActive(String query, Long categoryId, String sort) throws SQLException {
        String orderBy = switch (sort == null ? "" : sort) {
            case "price-asc" -> "p.price ASC";
            case "price-desc" -> "p.price DESC";
            case "name" -> "p.name ASC";
            default -> "p.created_at DESC";
        };
        StringBuilder sql = new StringBuilder(SELECT_PRODUCTS).append(" WHERE p.active = TRUE AND c.active=TRUE");
        if (query != null && !query.isBlank()) {
            sql.append(" AND (p.name LIKE ? OR p.description LIKE ?)");
        }
        if (categoryId != null) {
            sql.append(" AND p.category_id = ?");
        }
        sql.append(" GROUP BY p.id, c.name ORDER BY ").append(orderBy);
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (query != null && !query.isBlank()) {
                String term = "%" + query.trim() + "%";
                statement.setString(index++, term);
                statement.setString(index++, term);
            }
            if (categoryId != null) {
                statement.setLong(index, categoryId);
            }
            try (ResultSet result = statement.executeQuery()) {
                List<Product> products = new ArrayList<>();
                while (result.next()) {
                    products.add(mapProduct(result));
                }
                return products;
            }
        }
    }

    public List<Product> findFeatured(int limit) throws SQLException {
        String sql = SELECT_PRODUCTS
                + " WHERE p.active = TRUE AND c.active=TRUE GROUP BY p.id, c.name"
                + " ORDER BY p.discount_percent DESC, p.created_at DESC LIMIT ?";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, Math.max(1, Math.min(limit, 24)));
            try (ResultSet result = statement.executeQuery()) {
                List<Product> products = new ArrayList<>();
                while (result.next()) {
                    products.add(mapProduct(result));
                }
                return products;
            }
        }
    }

    public Optional<Product> findActiveById(long id) throws SQLException {
        String sql = SELECT_PRODUCTS + " WHERE p.active = TRUE AND c.active=TRUE AND p.id = ? GROUP BY p.id, c.name";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            try (ResultSet result = statement.executeQuery()) {
                return result.next() ? Optional.of(mapProduct(result)) : Optional.empty();
            }
        }
    }

    public List<Category> findCategories() throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT id, name, slug FROM categories WHERE active = TRUE ORDER BY name");
             ResultSet result = statement.executeQuery()) {
            List<Category> categories = new ArrayList<>();
            while (result.next()) {
                categories.add(new Category(result.getLong("id"), result.getString("name"),
                        result.getString("slug")));
            }
            return categories;
        }
    }

    public List<Product> findLowStock() throws SQLException {
        String sql = SELECT_PRODUCTS + " WHERE p.active=TRUE AND c.active=TRUE AND p.stock<=5 GROUP BY p.id,c.name ORDER BY p.stock,p.name";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            List<Product> products = new ArrayList<>();
            while (result.next()) {
                products.add(mapProduct(result));
            }
            return products;
        }
    }

    public List<ManagedProduct> findAllForAdmin() throws SQLException {
        String sql = """
                SELECT p.id,p.name,c.name AS category_name,p.slug,p.price,p.discount_percent,p.stock,p.active
                FROM products p JOIN categories c ON c.id=p.category_id ORDER BY p.name
                """;
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            List<ManagedProduct> products = new ArrayList<>();
            while (result.next()) {
                products.add(new ManagedProduct(result.getLong("id"), result.getString("name"),
                        result.getString("category_name"), result.getString("slug"),
                        result.getBigDecimal("price"), result.getBigDecimal("discount_percent"),
                        result.getInt("stock"), result.getBoolean("active")));
            }
            return products;
        }
    }

    public void setActive(long productId, boolean active) throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE products SET active=? WHERE id=?")) {
            statement.setBoolean(1, active);
            statement.setLong(2, productId);
            if (statement.executeUpdate() == 0) {
                throw new IllegalArgumentException("Product not found.");
            }
        }
    }

    public void addStock(long productId, int quantity) throws SQLException {
        if (quantity < 1 || quantity > 1_000_000) {
            throw new IllegalArgumentException("Restock quantity must be between 1 and 1,000,000.");
        }
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE products SET stock=stock+? WHERE id=? AND active=TRUE")) {
            statement.setInt(1, quantity);
            statement.setLong(2, productId);
            if (statement.executeUpdate() != 1) {
                throw new IllegalArgumentException("Active product not found.");
            }
        }
    }

    public void save(long id, long categoryId, String name, String slug, String description,
                     String imageUrl, java.math.BigDecimal price, java.math.BigDecimal discount,
                     int stock, boolean active) throws SQLException {
        String sql = id == 0
                ? "INSERT INTO products(category_id,name,slug,description,image_url,price,discount_percent,stock,active) VALUES(?,?,?,?,?,?,?,?,?)"
                : "UPDATE products SET category_id=?,name=?,slug=?,description=?,image_url=?,price=?,discount_percent=?,stock=?,active=? WHERE id=?";
        try (Connection connection = Database.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, categoryId);
            statement.setString(2, name);
            statement.setString(3, slug);
            statement.setString(4, description);
            statement.setString(5, imageUrl);
            statement.setBigDecimal(6, price);
            statement.setBigDecimal(7, discount);
            statement.setInt(8, stock);
            statement.setBoolean(9, active);
            if (id != 0) {
                statement.setLong(10, id);
            }
            statement.executeUpdate();
        }
    }

    private static Product mapProduct(ResultSet result) throws SQLException {
        return new Product(result.getLong("id"), result.getLong("category_id"),
                result.getString("category_name"), result.getString("name"), result.getString("slug"),
                result.getString("description"), result.getString("image_url"),
                result.getBigDecimal("price"), result.getBigDecimal("discount_percent"),
                result.getInt("stock"), result.getDouble("rating"), result.getInt("review_count"));
    }
}
