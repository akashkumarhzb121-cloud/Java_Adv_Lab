package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Set;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private static final Set<String> STATUSES = Set.of("PROCESSING", "SHIPPED", "DELIVERED", "CANCELLED");
    private final OrderDAO orders = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("orders", orders.findAll());
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            String status = request.getParameter("status");
            if (!STATUSES.contains(status)) {
                throw new IllegalArgumentException("Choose a supported order status.");
            }
            if (!orders.updateStatus(WebUtil.positiveId(request.getParameter("orderId"), "order"), status)) {
                throw new IllegalArgumentException("That order cannot transition to the selected status.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
