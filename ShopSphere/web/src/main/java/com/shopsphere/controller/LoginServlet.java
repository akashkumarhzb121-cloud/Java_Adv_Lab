package com.shopsphere.controller;

import com.shopsphere.model.User;
import com.shopsphere.service.AuthService;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final AuthService auth = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        WebUtil.csrfToken(request);
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Optional<User> user = auth.authenticate(request.getParameter("email"), request.getParameter("password"));
            if (user.isEmpty()) {
                request.setAttribute("error", "Email or password was not recognized.");
                request.setAttribute("csrfToken", WebUtil.csrfToken(request));
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }
            request.changeSessionId();
            request.getSession().setAttribute("user", user.get());
            String destination = user.get().isAdmin() ? "/admin" : "/products";
            response.sendRedirect(request.getContextPath() + destination);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
