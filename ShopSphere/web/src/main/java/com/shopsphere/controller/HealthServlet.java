package com.shopsphere.controller;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = "/health", initParams = @WebInitParam(name = "component", value = "ShopSphere web container"))
public class HealthServlet extends HttpServlet {
    private String component;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        component = config.getInitParameter("component");
        getServletContext().log(component + " servlet initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().println(component + " is running.");
    }

    @Override
    public void destroy() {
        getServletContext().log(component + " servlet destroyed.");
    }
}
