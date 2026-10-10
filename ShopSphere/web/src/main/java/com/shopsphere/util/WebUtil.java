package com.shopsphere.util;

import com.shopsphere.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

public final class WebUtil {
    private WebUtil() {
    }

    public static User user(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session == null ? null : (User) session.getAttribute("user");
    }

    public static String csrfToken(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String token = (String) session.getAttribute("csrfToken");
        if (token == null) {
            token = UUID.randomUUID().toString();
            session.setAttribute("csrfToken", token);
        }
        return token;
    }

    public static void error(HttpServlet servlet, HttpServletRequest request,
                             HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
    }

    public static void databaseError(HttpServlet servlet, HttpServletRequest request,
                                     HttpServletResponse response, Exception exception)
            throws ServletException, IOException {
        servlet.getServletContext().log("ShopSphere request failed while accessing the database.", exception);
        response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
        error(servlet, request, response, "We could not complete that request. Check the database configuration and try again.");
    }

    public static long positiveId(String value, String label) {
        try {
            long id = Long.parseLong(value);
            if (id > 0) {
                return id;
            }
        } catch (NumberFormatException ignored) {
            // Return one consistent validation error for malformed and non-positive ids.
        }
        throw new IllegalArgumentException("Choose a valid " + label + ".");
    }

    public static int boundedInt(String value, String label, int minimum, int maximum) {
        try {
            int number = Integer.parseInt(value);
            if (number >= minimum && number <= maximum) {
                return number;
            }
        } catch (NumberFormatException ignored) {
            // Report the same actionable validation message for all invalid values.
        }
        throw new IllegalArgumentException(label + " must be between " + minimum + " and " + maximum + ".");
    }
}
