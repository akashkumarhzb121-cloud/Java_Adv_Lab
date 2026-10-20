package com.shopsphere.service;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.OrderItem;
import com.shopsphere.model.OrderSummary;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class OrderService {
    private final OrderDAO orders = new OrderDAO();

    public List<OrderSummary> history(long userId) throws SQLException {
        return orders.findForCustomer(userId);
    }

    public Optional<OrderSummary> findOwned(long orderId, long userId) throws SQLException {
        if (!orders.ownsOrder(orderId, userId)) {
            return Optional.empty();
        }
        return orders.findForCustomer(userId).stream().filter(order -> order.id() == orderId).findFirst();
    }

    public List<OrderItem> items(long orderId, long userId) throws SQLException {
        return orders.findItems(orderId, userId);
    }
}
