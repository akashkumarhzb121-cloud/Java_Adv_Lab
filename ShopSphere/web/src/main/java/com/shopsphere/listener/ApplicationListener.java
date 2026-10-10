package com.shopsphere.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ApplicationListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        event.getServletContext().setAttribute("applicationName", "ShopSphere");
        event.getServletContext().setAttribute("activeSessions", new java.util.concurrent.atomic.AtomicInteger());
        event.getServletContext().log("ShopSphere application initialized.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        event.getServletContext().log("ShopSphere application stopped.");
    }
}
