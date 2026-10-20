@echo off
title ShopSphere 1-Click Launcher
echo ========================================================
echo        ShopSphere Advanced Java E-Commerce
echo ========================================================
echo.

set JAVA_HOME=C:\Program Files\Java\jdk-27
set CATALINA_HOME=D:\laptop-migrate\laptop-migrate\Java_Adv_Lab\apache-tomcat-11.0.25
set CATALINA_BASE=%CATALINA_HOME%

set SHOPSPHERE_DB_URL=jdbc:mysql://localhost:3306/shopsphere?useSSL=false^&serverTimezone=UTC^&allowPublicKeyRetrieval=true
set SHOPSPHERE_DB_USER=shopsphere_app
set SHOPSPHERE_DB_PASSWORD=java123

echo [1/3] Checking MySQL service...
sc query MySQL80 | find "RUNNING" >nul
if errorlevel 1 (
    echo Starting MySQL service...
    net start MySQL80
) else (
    echo MySQL80 is already running.
)

echo.
echo [2/3] Opening ShopSphere web browser in 4 seconds...
start /b cmd /c "timeout /t 4 /nobreak >nul && start http://localhost:8080/ShopSphere/"

echo.
echo [3/3] Launching Tomcat Server...
echo --------------------------------------------------------
echo Storefront URL: http://localhost:8080/ShopSphere/
echo Admin Console:  http://localhost:8080/ShopSphere/admin/login
echo Syllabus Demos: http://localhost:8080/ShopSphere/syllabus/index.jsp
echo.
echo Keep this window open while using the website.
echo Press Ctrl+C to stop the server anytime.
echo --------------------------------------------------------
echo.

"%CATALINA_HOME%\bin\catalina.bat" run
