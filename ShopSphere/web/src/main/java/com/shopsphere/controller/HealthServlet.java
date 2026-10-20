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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String format = request.getParameter("format");
        if ("text".equalsIgnoreCase(format)) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().println(component + " is running.");
            return;
        }

        request.setAttribute("component", component);
        request.setAttribute("serverInfo", getServletContext().getServerInfo());
        request.setAttribute("jvmVersion", System.getProperty("java.version"));
        request.setAttribute("osName", System.getProperty("os.name"));
        request.setAttribute("freeMemoryMB", Runtime.getRuntime().freeMemory() / (1024 * 1024));
        request.setAttribute("totalMemoryMB", Runtime.getRuntime().totalMemory() / (1024 * 1024));
        request.setAttribute("maxMemoryMB", Runtime.getRuntime().maxMemory() / (1024 * 1024));
        request.setAttribute("activeThreads", Thread.activeCount());

        request.getRequestDispatcher("/WEB-INF/views/health.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        getServletContext().log(component + " servlet destroyed.");
    }
}
