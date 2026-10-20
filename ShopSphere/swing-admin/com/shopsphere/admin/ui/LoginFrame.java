package com.shopsphere.admin.ui;

import javax.swing.*;
import java.awt.*;
import java.util.Arrays;

public final class LoginFrame extends JFrame {
    private final JTextField username = new JTextField(18);
    private final JPasswordField password = new JPasswordField(18);

    public LoginFrame() {
        super("ShopSphere Admin — Sign in");
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setResizable(false);
        JPanel form = new JPanel(new GridBagLayout());
        form.setBorder(BorderFactory.createEmptyBorder(20, 24, 16, 24));
        GridBagConstraints c = new GridBagConstraints();
        c.insets = new Insets(6, 6, 6, 6);
        c.anchor = GridBagConstraints.WEST;
        c.gridx = 0; c.gridy = 0; form.add(new JLabel("Username / Email"), c);
        c.gridx = 1; form.add(username, c);
        c.gridx = 0; c.gridy = 1; form.add(new JLabel("Password"), c);
        c.gridx = 1; form.add(password, c);
        JButton signIn = new JButton("Sign in");
        signIn.addActionListener(event -> authenticate());
        c.gridx = 1; c.gridy = 2; c.anchor = GridBagConstraints.EAST; form.add(signIn, c);
        JLabel hint = new JLabel("<html><small style='color:gray;'>Default: <b>admin</b> / <b>admin123</b> or <b>admin@shopsphere.local</b> / <b>Admin@ShopSphere25</b></small></html>");
        hint.setBorder(BorderFactory.createEmptyBorder(0, 16, 12, 16));
        add(form, BorderLayout.CENTER);
        add(hint, BorderLayout.SOUTH);
        getRootPane().setDefaultButton(signIn);
        pack();
        setLocationRelativeTo(null);
    }

    private void authenticate() {
        String expectedUser = System.getenv("SHOPSPHERE_ADMIN_USER");
        String expectedPassword = System.getenv("SHOPSPHERE_ADMIN_PASSWORD");
        char[] supplied = password.getPassword();
        String suppliedStr = new String(supplied);
        String userStr = username.getText().trim();

        boolean valid = false;
        if (expectedUser != null && !expectedUser.isBlank() && expectedPassword != null && !expectedPassword.isEmpty()) {
            valid = expectedUser.equals(userStr) && expectedPassword.equals(suppliedStr);
        } else {
            valid = ("admin".equalsIgnoreCase(userStr) || "admin@shopsphere.local".equalsIgnoreCase(userStr))
                    && ("admin123".equals(suppliedStr) || "Admin@ShopSphere25".equals(suppliedStr) || "admin".equals(suppliedStr));
        }

        Arrays.fill(supplied, '\0');
        password.setText("");
        if (!valid) {
            JOptionPane.showMessageDialog(this,
                    "Invalid username or password.\nUse admin / admin123 or admin@shopsphere.local / Admin@ShopSphere25",
                    "Sign-in failed", JOptionPane.ERROR_MESSAGE);
            return;
        }
        new DashboardFrame().setVisible(true);
        dispose();
    }
}
