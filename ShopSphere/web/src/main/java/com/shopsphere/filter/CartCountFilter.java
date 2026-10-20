package com.shopsphere.filter;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.model.User;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebFilter(urlPatterns = {"/home", "/products", "/product", "/cart", "/checkout", "/orders",
        "/order", "/wishlist", "/account/*", "/admin", "/admin/*", "/login", "/register"})
public class CartCountFilter implements Filter {
    private final CartDAO cart = new CartDAO();

    @Override
    public void doFilter(jakarta.servlet.ServletRequest request, jakarta.servlet.ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        User user = WebUtil.user(httpRequest);
        if (user != null) {
            try {
                httpRequest.setAttribute("cartCount", cart.countForUser(user.id()));
            } catch (SQLException exception) {
                httpRequest.getServletContext().log("Unable to load the current cart item count.", exception);
                httpRequest.setAttribute("cartCount", 0);
            }
        } else {
            httpRequest.setAttribute("cartCount", 0);
        }
        chain.doFilter(request, response);
    }
}
