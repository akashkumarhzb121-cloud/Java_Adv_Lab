package com.shopsphere.network;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/** Simple concurrent line-protocol inventory server. */
public final class InventoryServer {
    private static final int DEFAULT_PORT = 5050;
    private static final Map<String, InventoryItem> INVENTORY = new TreeMap<>();

    static {
        INVENTORY.put("SKU-1001", new InventoryItem("SKU-1001", "Wireless Mouse", 24));
        INVENTORY.put("SKU-1002", new InventoryItem("SKU-1002", "USB-C Hub", 12));
    }

    private InventoryServer() {}

    public static void main(String[] args) throws IOException {
        int port = args.length == 0 ? DEFAULT_PORT : Integer.parseInt(args[0]);
        ExecutorService clients = Executors.newVirtualThreadPerTaskExecutor();
        try (ServerSocket server = new ServerSocket(port)) {
            System.out.println("Inventory server listening on port " + port);
            while (!server.isClosed()) {
                Socket socket = server.accept();
                clients.submit(() -> serve(socket));
            }
        } finally {
            clients.shutdown();
        }
    }

    private static void serve(Socket socket) {
        try (socket;
             BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
             BufferedWriter output = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), StandardCharsets.UTF_8))) {
            String line;
            while ((line = input.readLine()) != null) {
                String response;
                try {
                    response = handle(line);
                } catch (ArithmeticException e) {
                    response = "ERROR quantity overflow";
                } catch (IllegalArgumentException e) {
                    response = "ERROR " + e.getMessage();
                }
                output.write(response);
                output.newLine();
                output.flush();
                if (line.equalsIgnoreCase("QUIT")) {
                    break;
                }
            }
        } catch (IOException e) {
            System.err.println("Client connection ended: " + e.getMessage());
        }
    }

    private static String handle(String commandLine) {
        String[] parts = commandLine.trim().split("\\s+", 4);
        if (parts.length == 0 || parts[0].isBlank()) {
            throw new IllegalArgumentException("empty command");
        }
        return switch (parts[0].toUpperCase()) {
            case "LIST" -> {
                synchronized (INVENTORY) {
                    yield INVENTORY.values().stream()
                            .map(i -> i.sku() + "|" + i.name() + "|" + i.quantity())
                            .reduce((a, b) -> a + ";" + b).orElse("EMPTY");
                }
            }
            case "GET" -> {
                require(parts, 2, "GET <sku>");
                synchronized (INVENTORY) {
                    InventoryItem item = INVENTORY.get(parts[1]);
                    yield item == null ? "NOT_FOUND" : item.sku() + "|" + item.name() + "|" + item.quantity();
                }
            }
            case "RESTOCK" -> {
                require(parts, 3, "RESTOCK <sku> <positive-quantity>");
                int amount;
                try {
                    amount = Integer.parseInt(parts[2]);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("quantity must be an integer");
                }
                if (amount <= 0) throw new IllegalArgumentException("quantity must be positive");
                synchronized (INVENTORY) {
                    InventoryItem old = INVENTORY.get(parts[1]);
                    if (old == null) yield "NOT_FOUND";
                    InventoryItem updated = new InventoryItem(old.sku(), old.name(), Math.addExact(old.quantity(), amount));
                    INVENTORY.put(old.sku(), updated);
                    yield "OK " + updated.sku() + "|" + updated.name() + "|" + updated.quantity();
                }
            }
            case "QUIT" -> "BYE";
            default -> throw new IllegalArgumentException("commands: LIST, GET <sku>, RESTOCK <sku> <quantity>, QUIT");
        };
    }

    private static void require(String[] parts, int count, String usage) {
        if (parts.length != count) throw new IllegalArgumentException("usage: " + usage);
    }
}
