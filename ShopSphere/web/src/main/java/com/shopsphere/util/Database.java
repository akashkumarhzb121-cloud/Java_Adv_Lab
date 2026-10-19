package com.shopsphere.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class Database {
    private Database() {
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv("SHOPSPHERE_DB_URL");
        String user = System.getenv("SHOPSPHERE_DB_USER");
        String password = System.getenv("SHOPSPHERE_DB_PASSWORD");
        if (url == null || url.isBlank() || user == null || user.isBlank() || password == null) {
            throw new SQLException("Set SHOPSPHERE_DB_URL, SHOPSPHERE_DB_USER, and SHOPSPHERE_DB_PASSWORD.");
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException exception) {
            throw new SQLException("MySQL JDBC driver is missing from the application classpath.", exception);
        }
        return DriverManager.getConnection(url, user, password);
    }
}
