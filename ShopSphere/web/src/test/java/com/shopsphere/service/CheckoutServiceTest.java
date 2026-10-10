package com.shopsphere.service;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class CheckoutServiceTest {
    private final CheckoutService checkout = new CheckoutService();

    @Test
    void rejectsInvalidPostalCodeBeforeAccessingDatabase() {
        IllegalArgumentException error = assertThrows(IllegalArgumentException.class, () ->
                checkout.placeOrder(1, "Home", "1 Main St", null, "Jaipur", "Rajasthan",
                        "!", "India", null, "MOCK_CARD"));
        assertEquals("Enter a valid postal code.", error.getMessage());
    }

    @Test
    void rejectsUnsupportedPaymentBeforeAccessingDatabase() {
        IllegalArgumentException error = assertThrows(IllegalArgumentException.class, () ->
                checkout.placeOrder(1, "Home", "1 Main St", null, "Jaipur", "Rajasthan",
                        "302001", "India", null, "CARD"));
        assertEquals("Choose a supported payment method.", error.getMessage());
    }
}
