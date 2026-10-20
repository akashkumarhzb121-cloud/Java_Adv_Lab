package com.shopsphere.admin.dao;

import com.shopsphere.admin.EntitySpec;
import java.util.List;

public final class CustomerDao extends JdbcEntityDao {
    public CustomerDao() {
        super(new EntitySpec("Customers", "users", "id",
                List.of("id", "full_name", "email", "phone", "role")));
    }
}
