package com.shopsphere.admin.ui;

import com.shopsphere.admin.dao.ProductDao;

public final class ProductFrame extends EntityFrame {
    public ProductFrame() {
        super(new ProductDao());
    }
}
