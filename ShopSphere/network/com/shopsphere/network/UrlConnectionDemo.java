package com.shopsphere.network;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;

public final class UrlConnectionDemo {
    private UrlConnectionDemo() {
    }

    public static void main(String[] args) throws IOException {
        String address = args.length == 0 ? "http://localhost:8080/ShopSphere/health" : args[0];
        var uri = URI.create(address);
        if (!"http".equalsIgnoreCase(uri.getScheme()) && !"https".equalsIgnoreCase(uri.getScheme())) {
            throw new IllegalArgumentException("Only HTTP and HTTPS URLs are supported.");
        }
        URLConnection connection = uri.toURL().openConnection();
        connection.setConnectTimeout(5_000);
        connection.setReadTimeout(5_000);
        connection.setRequestProperty("Accept", "text/plain,text/html");
        try {
            if (connection instanceof HttpURLConnection http) {
                System.out.println("HTTP status: " + http.getResponseCode());
            }
            try (var input = connection.getInputStream()) {
                byte[] buffer = new byte[2_048];
                int read = input.read(buffer);
                if (read >= 0) {
                    System.out.print(new String(buffer, 0, read, StandardCharsets.UTF_8));
                }
            }
        } finally {
            if (connection instanceof HttpURLConnection http) {
                http.disconnect();
            }
        }
    }
}
