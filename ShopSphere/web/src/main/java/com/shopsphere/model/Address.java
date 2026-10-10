package com.shopsphere.model;

public record Address(long id, String label, String line1, String line2, String city,
                      String state, String postalCode, String country) {
    public long getId() { return id; }
    public String getLabel() { return label; }
    public String getLine1() { return line1; }
    public String getLine2() { return line2; }
    public String getCity() { return city; }
    public String getState() { return state; }
    public String getPostalCode() { return postalCode; }
    public String getCountry() { return country; }
}
