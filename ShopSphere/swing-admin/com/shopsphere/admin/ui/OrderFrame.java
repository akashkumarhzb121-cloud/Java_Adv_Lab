package com.shopsphere.admin.ui;

import com.shopsphere.admin.dao.OrderDao;

public final class OrderFrame extends EntityFrame {
    public OrderFrame() {
        super(new OrderDao());
    }
}
