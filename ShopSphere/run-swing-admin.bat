@echo off
title ShopSphere Swing Desktop Admin
echo Launching ShopSphere Desktop Admin Module...
cd /d "%~dp0"
set mysql="C:\Users\akash\.m2\repository\com\mysql\mysql-connector-j\9.4.0\mysql-connector-j-9.4.0.jar"
java -cp "swing-admin\out;%mysql%" com.shopsphere.admin.AdminApp
pause
