package com.shopsphere.model;

public record Category(long id, String name, String slug, boolean active) {
    public Category(long id, String name, String slug) {
        this(id, name, slug, true);
    }

    public long getId() { return id; }
    public String getName() { return name; }
    public String getSlug() { return slug; }
    public boolean isActive() { return active; }
}
