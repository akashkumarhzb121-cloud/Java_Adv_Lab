package com.shopsphere.admin.ui;

import com.shopsphere.admin.dao.CategoryDao;

public final class CategoryFrame extends EntityFrame {
    public CategoryFrame() {
        super(new CategoryDao());
    }
}
