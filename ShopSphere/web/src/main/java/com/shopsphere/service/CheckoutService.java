package com.shopsphere.service;

import com.shopsphere.dao.CheckoutDAO;

import java.sql.SQLException;
import java.util.regex.Pattern;

public class CheckoutService {
    private static final Pattern POSTAL = Pattern.compile("^[A-Za-z0-9 -]{3,20}$");
    private final CheckoutDAO checkout = new CheckoutDAO();

    public long placeOrder(long userId, String label, String line1, String line2, String city,
                           String state, String postalCode, String country, String coupon, String method)
            throws SQLException {
        require(label, "Address label", 40);
        require(line1, "Address", 180);
        require(city, "City", 100);
        require(state, "State", 100);
        require(country, "Country", 80);
        if (postalCode == null || !POSTAL.matcher(postalCode.trim()).matches()) {
            throw new IllegalArgumentException("Enter a valid postal code.");
        }
        if (line2 != null && line2.length() > 180) {
            throw new IllegalArgumentException("Address line 2 is too long.");
        }
        if (!"MOCK_CARD".equals(method) && !"CASH_ON_DELIVERY".equals(method)) {
            throw new IllegalArgumentException("Choose a supported payment method.");
        }
        return checkout.placeOrder(userId, label.trim(), line1.trim(),
                line2 == null ? null : line2.trim(), city.trim(), state.trim(), postalCode.trim(),
                country.trim(), coupon, method);
    }

    private static void require(String value, String label, int max) {
        if (value == null || value.isBlank() || value.trim().length() > max) {
            throw new IllegalArgumentException(label + " is required and must be at most " + max + " characters.");
        }
    }
}
