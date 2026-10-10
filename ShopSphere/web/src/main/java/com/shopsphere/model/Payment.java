package com.shopsphere.model;

import java.math.BigDecimal;

public record Payment(String method, String status, BigDecimal amount, String transactionReference) {
}
