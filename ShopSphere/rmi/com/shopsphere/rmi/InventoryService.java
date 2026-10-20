package com.shopsphere.rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

public interface InventoryService extends Remote {
    List<InventoryItem> listInventory() throws RemoteException;

    InventoryItem findItem(String sku) throws RemoteException;

    InventoryItem restock(String sku, int quantity) throws RemoteException;

    InventoryItem getProduct(int id) throws RemoteException;

    int getStock(int productId) throws RemoteException;

    boolean updateStock(int productId, int quantity) throws RemoteException;
}
