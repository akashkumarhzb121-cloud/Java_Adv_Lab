package com.shopsphere.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

@WebFilter(urlPatterns = {"/home", "/login", "/register", "/products", "/product", "/cart", "/checkout",
        "/orders", "/order", "/wishlist", "/reviews", "/account/*", "/admin", "/admin/*", "/logout", "/locale"})
public class CsrfFilter implements Filter {
    @Override
    public void doFilter(jakarta.servlet.ServletRequest request, jakarta.servlet.ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        if ("GET".equalsIgnoreCase(httpRequest.getMethod())) {
            jakarta.servlet.http.HttpSession session = httpRequest.getSession();
            if (session.getAttribute("csrfToken") == null) {
                session.setAttribute("csrfToken", java.util.UUID.randomUUID().toString());
            }
        }
        if ("POST".equalsIgnoreCase(httpRequest.getMethod())) {
            HttpSession session = httpRequest.getSession(false);
            String expected = session == null ? null : (String) session.getAttribute("csrfToken");
            String provided = httpRequest.getParameter("_csrf");
            if (expected == null || provided == null
                    || !MessageDigest.isEqual(expected.getBytes(StandardCharsets.UTF_8),
                    provided.getBytes(StandardCharsets.UTF_8))) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid or expired request token.");
                return;
            }
        }
        chain.doFilter(request, response);
    }
}
