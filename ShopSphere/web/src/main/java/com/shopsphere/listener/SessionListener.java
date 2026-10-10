package com.shopsphere.listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.util.concurrent.atomic.AtomicInteger;

@WebListener
public class SessionListener implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        counter(event).incrementAndGet();
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        counter(event).updateAndGet(count -> Math.max(0, count - 1));
    }

    private static AtomicInteger counter(HttpSessionEvent event) {
        return (AtomicInteger) event.getSession().getServletContext().getAttribute("activeSessions");
    }
}
