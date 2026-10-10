package com.shopsphere.filter;

import com.shopsphere.model.User;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(urlPatterns = "/admin/*")
public class AdminFilter implements Filter {
    @Override
    public void doFilter(jakarta.servlet.ServletRequest request, jakarta.servlet.ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String path = httpRequest.getPathInfo();
        if ("/login".equals(path)) {
            chain.doFilter(request, response);
            return;
        }
        User user = WebUtil.user(httpRequest);
        if (user == null || !user.isAdmin()) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login");
            return;
        }
        chain.doFilter(request, response);
    }
}
