package com.shopsphere.controller;

import com.shopsphere.dao.AddressDAO;
import com.shopsphere.dao.CartDAO;
import com.shopsphere.service.CheckoutService;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private final CheckoutService checkout = new CheckoutService();
    private final CartDAO cart = new CartDAO();
    private final AddressDAO addresses = new AddressDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            var items = cart.findForUser(WebUtil.user(request).id());
            if (items.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            request.setAttribute("items", items);
            request.setAttribute("subtotal", items.stream().map(item -> item.lineTotal())
                    .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add));
            request.setAttribute("addresses", addresses.findForUser(WebUtil.user(request).id()));
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            long orderId = checkout.placeOrder(WebUtil.user(request).id(),
                    request.getParameter("label"), request.getParameter("line1"),
                    request.getParameter("line2"), request.getParameter("city"),
                    request.getParameter("state"), request.getParameter("postalCode"),
                    request.getParameter("country"), request.getParameter("coupon"),
                    request.getParameter("paymentMethod"));
            response.sendRedirect(request.getContextPath() + "/order?id=" + orderId + "&placed=1");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
