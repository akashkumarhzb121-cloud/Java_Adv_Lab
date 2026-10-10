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
        c.gridx = 0; c.gridy = 0; form.add(new JLabel("Username"), c);
        c.gridx = 1; form.add(username, c);
        c.gridx = 0; c.gridy = 1; form.add(new JLabel("Password"), c);
        c.gridx = 1; form.add(password, c);
        JButton signIn = new JButton("Sign in");
        signIn.addActionListener(event -> authenticate());
        c.gridx = 1; c.gridy = 2; c.anchor = GridBagConstraints.EAST; form.add(signIn, c);
        JLabel hint = new JLabel("Configure SHOPSPHERE_ADMIN_USER and SHOPSPHERE_ADMIN_PASSWORD.");
        hint.setBorder(BorderFactory.createEmptyBorder(0, 12, 12, 12));
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
        char[] expected = expectedPassword == null ? new char[0] : expectedPassword.toCharArray();
        boolean configured = expectedUser != null && !expectedUser.isBlank()
                && expectedPassword != null && !expectedPassword.isEmpty();
        boolean valid = configured && expectedUser.equals(username.getText())
                && Arrays.equals(expected, supplied);
        Arrays.fill(supplied, '\0');
        Arrays.fill(expected, '\0');
        password.setText("");
        if (!valid) {
            JOptionPane.showMessageDialog(this,
                    configured ? "Invalid username or password." : "Admin credentials are not configured in the environment.",
                    "Sign-in failed", JOptionPane.ERROR_MESSAGE);
            return;
        }
        new DashboardFrame().setVisible(true);
        dispose();
    }
}
