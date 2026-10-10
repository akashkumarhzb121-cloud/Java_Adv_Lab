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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final AuthService auth = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        WebUtil.csrfToken(request);
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            var user = auth.register(request.getParameter("fullName"), request.getParameter("email"),
                    request.getParameter("password"));
            request.changeSessionId();
            request.getSession().setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/products");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            request.setAttribute("csrfToken", WebUtil.csrfToken(request));
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
