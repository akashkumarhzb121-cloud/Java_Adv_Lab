package com.shopsphere.admin.ui;

import com.shopsphere.admin.dao.CustomerDao;

public final class CustomerFrame extends EntityFrame {
    public CustomerFrame() {
        super(new CustomerDao());
    }
}
