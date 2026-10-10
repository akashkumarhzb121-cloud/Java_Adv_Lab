package com.shopsphere.admin.dao;

import com.shopsphere.admin.DbConfig;
import com.shopsphere.admin.EntitySpec;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/** Prepared-statement DAO shared by admin screens; identifiers come only from fixed EntitySpecs. */
public class JdbcEntityDao {
    private final EntitySpec spec;

    public JdbcEntityDao(EntitySpec spec) {
        this.spec = spec;
    }

    public EntitySpec spec() {
        return spec;
    }

    public List<Object[]> findAll() throws SQLException {
        String sql = "SELECT " + String.join(", ", spec.columns()) + " FROM " + spec.table()
                + " ORDER BY " + spec.idColumn();
        try (Connection connection = DbConfig.openConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            List<Object[]> rows = new ArrayList<>();
            while (result.next()) {
                Object[] row = new Object[spec.columns().size()];
                for (int i = 0; i < row.length; i++) row[i] = result.getObject(i + 1);
                rows.add(row);
            }
            return rows;
        }
    }

    public void insert(Object[] values) throws SQLException {
        requireValues(values);
        List<String> editableColumns = spec.columns().subList(1, spec.columns().size());
        if (editableColumns.isEmpty()) throw new IllegalStateException("Entity has no editable columns");
        String placeholders = String.join(", ", java.util.Collections.nCopies(editableColumns.size(), "?"));
        String sql = "INSERT INTO " + spec.table() + " (" + String.join(", ", editableColumns)
                + ") VALUES (" + placeholders + ")";
        try (Connection connection = DbConfig.openConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            bind(statement, values);
            statement.executeUpdate();
        }
    }

    public void update(Object id, Object[] values) throws SQLException {
        requireValues(values);
        List<String> editableColumns = spec.columns().subList(1, spec.columns().size());
        String assignments = editableColumns.stream().map(column -> column + " = ?")
                .reduce((left, right) -> left + ", " + right).orElseThrow();
        String sql = "UPDATE " + spec.table() + " SET " + assignments + " WHERE " + spec.idColumn() + " = ?";
        try (Connection connection = DbConfig.openConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            bind(statement, values);
            statement.setObject(values.length + 1, id);
            if (statement.executeUpdate() == 0) throw new SQLException("No row found for ID " + id);
        }
    }

    public void delete(Object id) throws SQLException {
        String sql = "DELETE FROM " + spec.table() + " WHERE " + spec.idColumn() + " = ?";
        try (Connection connection = DbConfig.openConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, id);
            if (statement.executeUpdate() == 0) throw new SQLException("No row found for ID " + id);
        }
    }

    private void requireValues(Object[] values) {
        int expected = spec.columns().size() - 1;
        if (values == null || values.length != expected) {
            throw new IllegalArgumentException("Expected " + expected + " values");
        }
    }

    private static void bind(PreparedStatement statement, Object[] values) throws SQLException {
        for (int i = 0; i < values.length; i++) {
            Object value = values[i];
            statement.setObject(i + 1, value == null || value.toString().isBlank() ? null : value);
        }
    }
}
