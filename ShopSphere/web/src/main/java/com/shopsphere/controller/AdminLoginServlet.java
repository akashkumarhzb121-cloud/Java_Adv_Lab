package com.shopsphere.controller;

import com.shopsphere.service.AuthService;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    private final AuthService auth = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        WebUtil.csrfToken(request);
        request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            var account = auth.authenticate(request.getParameter("email"), request.getParameter("password"));
            if (account.isEmpty() || !account.get().isAdmin()) {
                request.setAttribute("error", "Administrator credentials were not recognized.");
                WebUtil.csrfToken(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
                return;
            }
            request.changeSessionId();
            request.getSession().setAttribute("user", account.get());
            response.sendRedirect(request.getContextPath() + "/admin");
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
