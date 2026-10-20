package com.shopsphere.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Database settings are supplied through environment variables or local fallbacks. */
public final class DbConfig {
    private DbConfig() {}

    public static Connection openConnection() throws SQLException {
        String url = setting("SHOPSPHERE_DB_URL", "jdbc:mysql://localhost:3306/shopsphere?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
        String user = setting("SHOPSPHERE_DB_USER", "shopsphere_app");
        String password = setting("SHOPSPHERE_DB_PASSWORD", "java123");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ignored) {
        }
        return DriverManager.getConnection(url, user, password);
    }

    private static String setting(String name, String defaultValue) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? defaultValue : value;
    }
}
