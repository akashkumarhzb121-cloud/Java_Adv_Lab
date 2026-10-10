package com.shopsphere.controller;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/jndi-demo")
public class JndiDemoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Object greeting = new InitialContext().lookup("java:comp/env/demo/greeting");
            request.setAttribute("greeting", greeting);
            request.getRequestDispatcher("/WEB-INF/views/jndi-demo.jsp").forward(request, response);
        } catch (NamingException exception) {
            getServletContext().log("JNDI demo resource lookup failed.", exception);
            response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "The JNDI demo resource could not be found. Check META-INF/context.xml.");
        }
    }
}
