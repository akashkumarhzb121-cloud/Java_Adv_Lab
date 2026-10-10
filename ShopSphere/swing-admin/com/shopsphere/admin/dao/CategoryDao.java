package com.shopsphere.admin.dao;

import com.shopsphere.admin.EntitySpec;
import java.util.List;

public final class CategoryDao extends JdbcEntityDao {
    public CategoryDao() {
        super(new EntitySpec("Categories", "categories", "id", List.of("id", "name", "description")));
    }
}
