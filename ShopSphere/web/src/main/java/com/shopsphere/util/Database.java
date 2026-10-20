package com.shopsphere.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class Database {
    private Database() {
    }

    public static Connection getConnection() throws SQLException {
        String url = firstNonBlank(System.getenv("SHOPSPHERE_DB_URL"),
                "jdbc:mysql://localhost:3306/shopsphere?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
        String user = firstNonBlank(System.getenv("SHOPSPHERE_DB_USER"), "shopsphere_app");
        String password = System.getenv("SHOPSPHERE_DB_PASSWORD");
        if (password == null) {
            password = "java123";
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException exception) {
            throw new SQLException("MySQL JDBC driver is missing from the application classpath.", exception);
        }
        return DriverManager.getConnection(url, user, password);
    }

    private static String firstNonBlank(String value, String fallback) {
        return value == null || value.isBlank() ? fallback : value;
    }
}
