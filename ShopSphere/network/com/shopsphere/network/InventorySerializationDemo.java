package com.shopsphere.network;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputFilter;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.List;

/** Demonstrates serializing inventory DTOs without writing generated data to disk. */
public final class InventorySerializationDemo {
    private InventorySerializationDemo() {}

    public static void main(String[] args) throws Exception {
        List<InventoryItem> inventory = List.of(
                new InventoryItem("SKU-1001", "Wireless Mouse", 24),
                new InventoryItem("SKU-1002", "USB-C Hub", 12));
        byte[] serialized;
        try (ByteArrayOutputStream bytes = new ByteArrayOutputStream();
             ObjectOutputStream output = new ObjectOutputStream(bytes)) {
            output.writeObject(inventory);
            output.flush();
            serialized = bytes.toByteArray();
        }
        try (ObjectInputStream input = new ObjectInputStream(new ByteArrayInputStream(serialized))) {
            input.setObjectInputFilter(info -> info.depth() > 10 || info.references() > 100
                    ? ObjectInputFilter.Status.REJECTED : ObjectInputFilter.Status.UNDECIDED);
            @SuppressWarnings("unchecked")
            List<InventoryItem> restored = (List<InventoryItem>) input.readObject();
            restored.forEach(System.out::println);
            System.out.println("Serialized bytes: " + serialized.length);
        }
    }
}
