@echo off
title ShopSphere Java RMI Remote Inventory Demo
echo ========================================================
echo        ShopSphere Java RMI Registry Demo
echo ========================================================
cd /d "%~dp0"
echo Starting RMI Registry and Inventory Server...
start "RMI Registry Server" cmd /c "java -cp rmi\out com.shopsphere.rmi.InventoryServer"
timeout /t 2 /nobreak >nul
echo Launching RMI Client lookup...
echo.
java -cp rmi\out com.shopsphere.rmi.InventoryClient
pause
