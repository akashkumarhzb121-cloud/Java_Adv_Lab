package com.shopsphere.controller;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.model.User;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private final CartDAO cart = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadCart(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = WebUtil.user(request);
        try {
            String action = request.getParameter("action");
            long productId = WebUtil.positiveId(request.getParameter("productId"), "product");
            if ("add".equals(action)) {
                cart.add(user.id(), productId, WebUtil.boundedInt(request.getParameter("quantity"),
                        "Quantity", 1, 99));
            } else if ("update".equals(action)) {
                cart.setQuantity(user.id(), productId, WebUtil.boundedInt(request.getParameter("quantity"),
                        "Quantity", 1, 99));
            } else if ("remove".equals(action)) {
                cart.remove(user.id(), productId);
            } else {
                throw new IllegalArgumentException("Choose a valid cart action.");
            }
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            loadCart(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    private void loadCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            var items = cart.findForUser(WebUtil.user(request).id());
            java.math.BigDecimal total = items.stream().map(item -> item.lineTotal())
                    .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);
            request.setAttribute("items", items);
            request.setAttribute("subtotal", total);
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
