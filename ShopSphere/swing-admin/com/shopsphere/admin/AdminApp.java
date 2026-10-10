package com.shopsphere.admin;

import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import com.shopsphere.admin.ui.LoginFrame;

public final class AdminApp {
    private AdminApp() {}

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            try {
                UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            } catch (Exception ignored) {
                // Swing's default look and feel remains usable.
            }
            new LoginFrame().setVisible(true);
        });
    }
}
