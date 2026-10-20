@echo off
title ShopSphere Java.net Socket Inventory Demo
echo ========================================================
echo        ShopSphere Socket Client-Server Demo
echo ========================================================
cd /d "%~dp0"
echo Starting Inventory Server on port 5050...
start "Inventory Server (Port 5050)" cmd /c "java -cp network\out com.shopsphere.network.InventoryServer"
timeout /t 2 /nobreak >nul
echo Launching Interactive Inventory Client...
echo Commands you can type: LIST, GET SKU-1001, RESTOCK SKU-1001 5, QUIT
echo.
java -cp network\out com.shopsphere.network.InventoryClient
pause
