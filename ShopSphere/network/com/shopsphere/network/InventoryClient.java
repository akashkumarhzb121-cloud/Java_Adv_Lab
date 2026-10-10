package com.shopsphere.network;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.nio.charset.StandardCharsets;

public final class InventoryClient {
    private InventoryClient() {}

    public static void main(String[] args) throws IOException {
        String host = args.length > 0 ? args[0] : "localhost";
        int port = args.length > 1 ? Integer.parseInt(args[1]) : 5050;
        try (Socket socket = new Socket(host, port);
             BufferedReader server = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
             BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), StandardCharsets.UTF_8));
             BufferedReader console = new BufferedReader(new InputStreamReader(System.in, StandardCharsets.UTF_8))) {
            System.out.println("Connected to " + host + ":" + port + ". Commands: LIST, GET <sku>, RESTOCK <sku> <quantity>, QUIT");
            String command;
            while ((command = console.readLine()) != null) {
                writer.write(command);
                writer.newLine();
                writer.flush();
                String response;
                while ((response = server.readLine()) != null) {
                    System.out.println(response);
                    if (!response.contains("\n")) break;
                }
                if (command.equalsIgnoreCase("QUIT")) break;
            }
        }
    }
}
