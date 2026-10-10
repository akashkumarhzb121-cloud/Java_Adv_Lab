package com.shopsphere.model;

public record CustomerAccount(User user, boolean active) {
    public User getUser() { return user; }
    public boolean isActive() { return active; }
}
