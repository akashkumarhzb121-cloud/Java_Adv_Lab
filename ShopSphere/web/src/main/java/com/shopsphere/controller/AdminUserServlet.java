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

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private final AdminDAO admin = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("users", admin.customers());
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            boolean active = "activate".equals(request.getParameter("action"));
            if (!active && !"deactivate".equals(request.getParameter("action"))) {
                throw new IllegalArgumentException("Choose activate or deactivate.");
            }
            admin.setCustomerActive(WebUtil.positiveId(request.getParameter("userId"), "customer"), active);
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
