package com.shopsphere.controller;

import com.shopsphere.util.EnvironmentDataSource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import com.shopsphere.util.Database;

@WebServlet("/syllabus/jstl-sql")
public class SyllabusSqlServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (var connection = Database.getConnection()) {
            if (!connection.isValid(2)) {
                throw new SQLException("Database connection validation failed.");
            }
        } catch (SQLException exception) {
            getServletContext().log("JSTL SQL demonstration could not connect to the configured database.", exception);
            response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "Set the ShopSphere database environment variables and retry the syllabus SQL example.");
            return;
        }
        request.setAttribute("demoDataSource", new EnvironmentDataSource());
        request.getRequestDispatcher("/syllabus/jstl-sql.jsp").forward(request, response);
    }
}
