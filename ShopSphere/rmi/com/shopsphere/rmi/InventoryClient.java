package com.shopsphere.rmi;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Scanner;

public final class InventoryClient {
    private InventoryClient() {}

    public static void main(String[] args) throws Exception {
        String host = args.length == 0 ? "127.0.0.1" : args[0];
        int port = args.length < 2 ? Registry.REGISTRY_PORT : Integer.parseInt(args[1]);
        Registry registry = LocateRegistry.getRegistry(host, port);
        InventoryService service = (InventoryService) registry.lookup("ShopSphereInventory");
        try (Scanner input = new Scanner(System.in)) {
            System.out.println("Commands: LIST, GET <sku>, GETSTOCK <id>, SETSTOCK <id> <qty>, RESTOCK <sku> <quantity>, QUIT");
            while (input.hasNextLine()) {
                String line = input.nextLine().trim();
                String[] parts = line.split("\\s+");
                if (line.equalsIgnoreCase("QUIT")) return;
                try {
                    switch (parts[0].toUpperCase()) {
                        case "LIST" -> service.listInventory().forEach(System.out::println);
                        case "GET" -> {
                            if (parts.length != 2) throw new IllegalArgumentException("Usage: GET <sku>");
                            System.out.println(service.findItem(parts[1]));
                        }
                        case "GETSTOCK" -> {
                            if (parts.length != 2) throw new IllegalArgumentException("Usage: GETSTOCK <id>");
                            int id = Integer.parseInt(parts[1]);
                            System.out.println(service.getProduct(id) + " stock=" + service.getStock(id));
                        }
                        case "SETSTOCK" -> {
                            if (parts.length != 3) throw new IllegalArgumentException("Usage: SETSTOCK <id> <qty>");
                            System.out.println(service.updateStock(Integer.parseInt(parts[1]), Integer.parseInt(parts[2])));
                        }
                        case "RESTOCK" -> {
                            if (parts.length != 3) throw new IllegalArgumentException("Usage: RESTOCK <sku> <quantity>");
                            System.out.println(service.restock(parts[1], Integer.parseInt(parts[2])));
                        }
                        default -> System.out.println("Unknown command");
                    }
                } catch (Exception e) {
                    System.err.println("Request failed: " + e.getMessage());
                }
            }
        }
    }
}
