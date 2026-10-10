package com.shopsphere.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/locale")
public class LocaleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String language = request.getParameter("language");
        if (!"en".equals(language) && !"hi".equals(language)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unsupported language.");
            return;
        }
        request.getSession().setAttribute("locale", language);
        response.sendRedirect(request.getContextPath() + "/products");
    }
}
