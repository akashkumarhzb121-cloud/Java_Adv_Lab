package com.shopsphere.admin.ui;

import com.shopsphere.admin.dao.CategoryDao;
import com.shopsphere.admin.dao.CustomerDao;
import com.shopsphere.admin.dao.InventoryDao;
import com.shopsphere.admin.dao.OrderDao;
import com.shopsphere.admin.dao.ProductDao;

import javax.swing.*;
import java.awt.*;

public final class DashboardFrame extends JFrame {
    public DashboardFrame() {
        super("ShopSphere Admin Dashboard");
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setSize(620, 390);
        setLocationRelativeTo(null);
        JLabel heading = new JLabel("ShopSphere Administration", SwingConstants.CENTER);
        heading.setFont(heading.getFont().deriveFont(Font.BOLD, 24f));
        heading.setBorder(BorderFactory.createEmptyBorder(24, 10, 12, 10));
        JPanel actions = new JPanel(new GridLayout(3, 2, 12, 12));
        actions.setBorder(BorderFactory.createEmptyBorder(18, 50, 28, 50));
        addButton(actions, "Products", () -> new ProductFrame().setVisible(true));
        addButton(actions, "Categories", () -> new CategoryFrame().setVisible(true));
        addButton(actions, "Customers", () -> new CustomerFrame().setVisible(true));
        addButton(actions, "Orders", () -> new OrderFrame().setVisible(true));
        addButton(actions, "Inventory", () -> new InventoryFrame(new InventoryDao()).setVisible(true));
        addButton(actions, "Sign out", () -> {
            new LoginFrame().setVisible(true);
            dispose();
        });
        add(heading, BorderLayout.NORTH);
        add(actions, BorderLayout.CENTER);
    }

    private static void addButton(JPanel panel, String text, Runnable action) {
        JButton button = new JButton(text);
        button.addActionListener(event -> action.run());
        panel.add(button);
    }
}
