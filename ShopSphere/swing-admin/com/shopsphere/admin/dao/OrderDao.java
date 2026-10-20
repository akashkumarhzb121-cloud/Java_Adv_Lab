package com.shopsphere.admin.dao;

import com.shopsphere.admin.EntitySpec;
import java.util.List;

public final class OrderDao extends JdbcEntityDao {
    public OrderDao() {
        super(new EntitySpec("Orders", "orders", "id",
                List.of("id", "user_id", "status", "subtotal", "discount", "total")));
    }
}
