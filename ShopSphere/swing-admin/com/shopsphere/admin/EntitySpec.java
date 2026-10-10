package com.shopsphere.admin;

import java.util.List;

public record EntitySpec(String title, String table, String idColumn, List<String> columns) {
    public EntitySpec {
        columns = List.copyOf(columns);
        if (!table.matches("[A-Za-z_][A-Za-z0-9_]*")
                || !idColumn.matches("[A-Za-z_][A-Za-z0-9_]*")
                || columns.isEmpty()
                || columns.stream().anyMatch(c -> !c.matches("[A-Za-z_][A-Za-z0-9_]*"))) {
            throw new IllegalArgumentException("Invalid SQL entity mapping");
        }
    }
}
