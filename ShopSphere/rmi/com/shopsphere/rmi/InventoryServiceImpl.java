package com.shopsphere.rmi;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public final class InventoryServiceImpl extends UnicastRemoteObject implements InventoryService {
    private final Map<String, InventoryItem> inventory = new TreeMap<>();

    public InventoryServiceImpl() throws RemoteException {
        super();
        inventory.put("SKU-1001", new InventoryItem("SKU-1001", "Wireless Mouse", 24));
        inventory.put("SKU-1002", new InventoryItem("SKU-1002", "USB-C Hub", 12));
    }

    @Override
    public synchronized List<InventoryItem> listInventory() {
        return List.copyOf(inventory.values());
    }

    @Override
    public synchronized InventoryItem findItem(String sku) {
        return inventory.get(sku);
    }

    @Override
    public synchronized InventoryItem restock(String sku, int quantity) throws RemoteException {
        if (quantity <= 0) throw new RemoteException("Quantity must be positive");
        InventoryItem current = inventory.get(sku);
        if (current == null) throw new RemoteException("No inventory item for SKU " + sku);
        try {
            InventoryItem updated = new InventoryItem(sku, current.name(), Math.addExact(current.quantity(), quantity));
            inventory.put(sku, updated);
            return updated;
        } catch (ArithmeticException e) {
            throw new RemoteException("Quantity overflow", e);
        }
    }
}
