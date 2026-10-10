package com.shopsphere.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Database settings are supplied through environment variables, not source code. */
public final class DbConfig {
    private DbConfig() {}

    public static Connection openConnection() throws SQLException {
        String url = setting("SHOPSPHERE_DB_URL", "jdbc:mysql://localhost:3306/shopsphere");
        String user = setting("SHOPSPHERE_DB_USER", "root");
        String password = setting("SHOPSPHERE_DB_PASSWORD", "");
        return DriverManager.getConnection(url, user, password);
    }

    private static String setting(String name, String defaultValue) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? defaultValue : value;
    }
}
