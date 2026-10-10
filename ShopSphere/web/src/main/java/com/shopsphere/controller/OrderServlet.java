package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.User;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/orders", "/order"})
public class OrderServlet extends HttpServlet {
    private final OrderDAO orders = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = WebUtil.user(request);
        try {
            if ("/order".equals(request.getServletPath())) {
                long id = WebUtil.positiveId(request.getParameter("id"), "order");
                if (!orders.ownsOrder(id, user.id())) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                request.setAttribute("orderId", id);
                request.setAttribute("order", orders.findForCustomer(user.id()).stream()
                        .filter(order -> order.id() == id).findFirst().orElseThrow());
                request.setAttribute("items", orders.findItems(id, user.id()));
                request.setAttribute("placed", "1".equals(request.getParameter("placed")));
                request.getRequestDispatcher("/WEB-INF/views/order-details.jsp").forward(request, response);
                return;
            }
            request.setAttribute("orders", orders.findForCustomer(user.id()));
            request.getRequestDispatcher("/WEB-INF/views/orders.jsp").forward(request, response);
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
