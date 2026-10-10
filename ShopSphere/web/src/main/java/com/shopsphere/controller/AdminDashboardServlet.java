package com.shopsphere.controller;

import com.shopsphere.dao.AdminDAO;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
    private final AdminDAO admin = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("stats", admin.dashboard());
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
