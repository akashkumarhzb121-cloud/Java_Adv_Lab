package com.shopsphere.admin.dao;

import com.shopsphere.admin.EntitySpec;
import java.util.List;

public final class CustomerDao extends JdbcEntityDao {
    public CustomerDao() {
        super(new EntitySpec("Customers", "customers", "id",
                List.of("id", "name", "email", "phone", "address")));
    }
}
