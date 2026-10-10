package com.shopsphere.controller;

import com.shopsphere.dao.CategoryDAO;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {
    private final CategoryDAO categories = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("categories", categories.findAll());
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            String action = request.getParameter("action");
            if ("setActive".equals(action)) {
                categories.setActive(WebUtil.positiveId(request.getParameter("id"), "category"),
                        "true".equals(request.getParameter("active")));
            } else if ("add".equals(action) || action == null) {
                categories.add(request.getParameter("name"), request.getParameter("description"));
            } else {
                throw new IllegalArgumentException("Choose a valid category action.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
