package com.shopsphere.service;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Category;
import com.shopsphere.model.Product;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class ProductService {
    private final ProductDAO products = new ProductDAO();

    public List<Product> browse(String query, String category, String sort) throws SQLException {
        Long categoryId = null;
        if (category != null && !category.isBlank()) {
            try {
                categoryId = Long.parseLong(category);
            } catch (NumberFormatException exception) {
                throw new IllegalArgumentException("Invalid category.");
            }
        }
        return products.findActive(query, categoryId, sort);
    }

    public Optional<Product> find(long id) throws SQLException {
        return products.findActiveById(id);
    }

    public List<Category> categories() throws SQLException {
        return products.findCategories();
    }

    public ProductDAO dao() {
        return products;
    }
}
