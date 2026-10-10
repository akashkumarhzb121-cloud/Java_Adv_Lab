package com.shopsphere.admin.ui;

import com.shopsphere.admin.dao.InventoryDao;
import com.shopsphere.admin.controller.InventoryController;

import javax.swing.*;

public final class InventoryFrame extends EntityFrame {
    private final InventoryController inventoryController;

    public InventoryFrame(InventoryDao dao) {
        super(dao);
        this.inventoryController = new InventoryController(dao);
        addAction("Restock", this::restockSelected);
    }

    private void restockSelected() {
        Object id = selectedId();
        if (id == null) {
            JOptionPane.showMessageDialog(this, "Select a product to restock.");
            return;
        }
        String input = JOptionPane.showInputDialog(this, "Units to add:", "Restock inventory", JOptionPane.QUESTION_MESSAGE);
        if (input == null) return;
        try {
            int amount = Integer.parseInt(input.trim());
            inventoryController.restock(id, amount);
            refreshRows();
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "Enter a whole number greater than zero.", "Invalid quantity", JOptionPane.ERROR_MESSAGE);
        } catch (Exception e) {
            showDatabaseError(e);
        }
    }
}
