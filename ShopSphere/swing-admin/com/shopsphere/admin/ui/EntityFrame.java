package com.shopsphere.admin.ui;

import com.shopsphere.admin.EntitySpec;
import com.shopsphere.admin.controller.EntityController;
import com.shopsphere.admin.dao.JdbcEntityDao;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.SQLException;
import java.util.List;

public class EntityFrame extends JFrame {
    protected final JdbcEntityDao dao;
    protected final EntityController controller;
    protected final JTable table;
    protected final DefaultTableModel model;
    protected final JPanel toolbar = new JPanel(new FlowLayout(FlowLayout.LEFT));
    private final EntitySpec spec;

    public EntityFrame(JdbcEntityDao dao) {
        super("ShopSphere Admin — " + dao.spec().title());
        this.dao = dao;
        this.controller = new EntityController(dao);
        this.spec = dao.spec();
        this.model = new DefaultTableModel(spec.columns().toArray(), 0) {
            @Override public boolean isCellEditable(int row, int column) { return false; }
        };
        this.table = new JTable(model);
        table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        setSize(900, 520);
        setLocationRelativeTo(null);
        addAction("Add", this::addRow);
        addAction("Edit", this::editRow);
        addAction("Delete", this::deleteRow);
        addAction("Refresh", this::refreshRows);
        add(toolbar, BorderLayout.NORTH);
        add(new JScrollPane(table), BorderLayout.CENTER);
        refreshRows();
    }

    protected final void addAction(String label, Runnable action) {
        JButton button = new JButton(label);
        button.addActionListener(event -> action.run());
        toolbar.add(button);
    }

    protected Object selectedId() {
        int row = table.getSelectedRow();
        if (row < 0) return null;
        int modelRow = table.convertRowIndexToModel(row);
        return model.getValueAt(modelRow, 0);
    }

    protected void refreshRows() {
        try {
            List<Object[]> rows = controller.listRows();
            model.setRowCount(0);
            rows.forEach(model::addRow);
        } catch (SQLException e) {
            showDatabaseError(e);
        }
    }

    protected void showDatabaseError(Exception e) {
        JOptionPane.showMessageDialog(this,
                "Database operation failed: " + e.getMessage()
                        + "\nCheck SHOPSPHERE_DB_URL, SHOPSPHERE_DB_USER, SHOPSPHERE_DB_PASSWORD and the ShopSphere table schema.",
                "Database error", JOptionPane.ERROR_MESSAGE);
    }

    private void addRow() {
        Object[] values = promptValues(null);
        if (values == null) return;
        try {
            controller.create(values);
            refreshRows();
        } catch (SQLException | IllegalArgumentException e) {
            showDatabaseError(e);
        }
    }

    private void editRow() {
        int row = table.getSelectedRow();
        if (row < 0) {
            JOptionPane.showMessageDialog(this, "Select a row to edit.");
            return;
        }
        int modelRow = table.convertRowIndexToModel(row);
        Object id = model.getValueAt(modelRow, 0);
        Object[] existing = new Object[spec.columns().size() - 1];
        for (int column = 1; column < spec.columns().size(); column++) {
            existing[column - 1] = model.getValueAt(modelRow, column);
        }
        Object[] values = promptValues(existing);
        if (values == null) return;
        try {
            controller.edit(id, values);
            refreshRows();
        } catch (SQLException | IllegalArgumentException e) {
            showDatabaseError(e);
        }
    }

    private void deleteRow() {
        Object id = selectedId();
        if (id == null) {
            JOptionPane.showMessageDialog(this, "Select a row to delete.");
            return;
        }
        int choice = JOptionPane.showConfirmDialog(this, "Delete selected " + spec.title().toLowerCase() + " row?",
                "Confirm delete", JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE);
        if (choice != JOptionPane.YES_OPTION) return;
        try {
            controller.remove(id);
            refreshRows();
        } catch (SQLException e) {
            showDatabaseError(e);
        }
    }

    private Object[] promptValues(Object[] existing) {
        List<String> columns = spec.columns().subList(1, spec.columns().size());
        JPanel fields = new JPanel(new GridLayout(columns.size(), 2, 8, 6));
        JTextField[] inputs = new JTextField[columns.size()];
        for (int i = 0; i < columns.size(); i++) {
            fields.add(new JLabel(columns.get(i)));
            inputs[i] = new JTextField(existing == null || existing[i] == null ? "" : existing[i].toString(), 24);
            fields.add(inputs[i]);
        }
        int result = JOptionPane.showConfirmDialog(this, fields, existing == null ? "Add row" : "Edit row",
                JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
        if (result != JOptionPane.OK_OPTION) return null;
        Object[] values = new Object[inputs.length];
        for (int i = 0; i < inputs.length; i++) values[i] = inputs[i].getText().trim();
        return values;
    }
}
