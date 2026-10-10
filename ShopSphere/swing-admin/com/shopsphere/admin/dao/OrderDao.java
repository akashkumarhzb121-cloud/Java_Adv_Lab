package com.shopsphere.admin.dao;

import com.shopsphere.admin.EntitySpec;
import java.util.List;

public final class OrderDao extends JdbcEntityDao {
    public OrderDao() {
        super(new EntitySpec("Orders", "orders", "id",
                List.of("id", "customer_id", "order_date", "status", "total_amount")));
    }
}
