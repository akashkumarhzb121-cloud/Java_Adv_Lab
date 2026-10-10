package com.shopsphere.rmi;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public final class InventoryServer {
    private InventoryServer() {}

    public static void main(String[] args) throws Exception {
        int port = args.length == 0 ? Registry.REGISTRY_PORT : Integer.parseInt(args[0]);
        Registry registry;
        try {
            registry = LocateRegistry.createRegistry(port);
            System.out.println("Started RMI registry on port " + port);
        } catch (java.rmi.server.ExportException alreadyRunning) {
            registry = LocateRegistry.getRegistry(port);
            registry.list();
        }
        registry.rebind("ShopSphereInventory", new InventoryServiceImpl());
        System.out.println("ShopSphere inventory service ready on port " + port);
    }
}
