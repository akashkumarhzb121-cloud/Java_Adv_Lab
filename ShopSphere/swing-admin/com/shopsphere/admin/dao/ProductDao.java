package com.shopsphere.admin.dao;

import com.shopsphere.admin.EntitySpec;
import java.util.List;

public final class ProductDao extends JdbcEntityDao {
    public ProductDao() {
        super(new EntitySpec("Products", "products", "id",
                List.of("id", "name", "description", "price", "stock", "category_id")));
    }
}
