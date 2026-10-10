package com.shopsphere.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class PasswordUtilTest {
    @Test
    void hashesAreSaltedAndVerifyOnlyTheCorrectPassword() {
        String first = PasswordUtil.hash("a-long-development-password");
        String second = PasswordUtil.hash("a-long-development-password");

        assertNotEquals(first, second);
        assertTrue(PasswordUtil.verify("a-long-development-password", first));
        assertFalse(PasswordUtil.verify("incorrect-password", first));
    }

    @Test
    void malformedOrUnsupportedHashesAreRejected() {
        assertFalse(PasswordUtil.verify("password", "not-a-password-hash"));
        assertFalse(PasswordUtil.verify("password", "pbkdf2-sha256$1$bad$bad"));
    }

    @Test
    void developmentSeedPasswordsMatchTheirStoredHashes() {
        assertTrue(PasswordUtil.verify("Admin@ShopSphere25",
                "pbkdf2-sha256$210000$c2hvcHNwaGVyZS1hZG1pbi0yMDI2$HAZj9oINeHefe92O3/LMV1WF0fyp5YymIO94kBgDQ/E="));
        assertTrue(PasswordUtil.verify("Customer@ShopSphere25",
                "pbkdf2-sha256$210000$c2hvcHNwaGVyZS1jdXN0b21lci0yMDI2$5ciIO7+BIgXp+XVuEEHwrXUQxURFg1cJz8uSUQxy4hU="));
    }
}
