package com.shopsphere.service;

import com.shopsphere.dao.UserDAO;
import com.shopsphere.model.User;
import com.shopsphere.util.PasswordUtil;

import java.sql.SQLException;
import java.util.Locale;
import java.util.Optional;
import java.util.regex.Pattern;

public class AuthService {
    private static final Pattern EMAIL = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    private final UserDAO users = new UserDAO();

    public Optional<User> authenticate(String email, String password) throws SQLException {
        if (email == null || password == null) {
            return Optional.empty();
        }
        return users.findByEmail(email.trim().toLowerCase(Locale.ROOT))
                .filter(account -> PasswordUtil.verify(password, account.passwordHash()))
                .map(UserDAO.AuthenticatedUser::user);
    }

    public User register(String fullName, String email, String password) throws SQLException {
        String name = fullName == null ? "" : fullName.trim();
        String normalizedEmail = email == null ? "" : email.trim().toLowerCase(Locale.ROOT);
        if (name.length() < 2 || name.length() > 120 || !EMAIL.matcher(normalizedEmail).matches()
                || normalizedEmail.length() > 254 || password == null || password.length() < 10
                || password.length() > 128) {
            throw new IllegalArgumentException("Enter a valid name and email, and a password of 10–128 characters.");
        }
        return users.create(name, normalizedEmail, PasswordUtil.hash(password));
    }
}
