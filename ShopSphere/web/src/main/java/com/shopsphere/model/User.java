package com.shopsphere.model;

public record User(long id, String fullName, String email, String role, String phone) {
    public boolean isAdmin() {
        return "ADMIN".equals(role);
    }

    /** Jakarta EL record resolver looks up {@code admin()}, not {@code isAdmin()}. */
    public boolean admin() {
        return isAdmin();
    }

    public long getId() { return id; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getRole() { return role; }
    public String getPhone() { return phone; }
    public boolean getAdmin() { return isAdmin(); }
}
