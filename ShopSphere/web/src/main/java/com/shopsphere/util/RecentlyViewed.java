package com.shopsphere.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;

public final class RecentlyViewed {
    private static final String COOKIE = "ss_viewed";
    private static final int LIMIT = 8;

    private RecentlyViewed() {
    }

    public static void remember(HttpServletRequest request, HttpServletResponse response, long productId) {
        LinkedHashSet<Long> ids = new LinkedHashSet<>();
        ids.add(productId);
        for (long existing : idsFrom(request)) {
            ids.add(existing);
            if (ids.size() >= LIMIT) {
                break;
            }
        }
        Cookie cookie = new Cookie(COOKIE, encode(ids));
        cookie.setMaxAge(60 * 60 * 24 * 14);
        cookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    public static List<Long> idsFrom(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return List.of();
        }
        for (Cookie cookie : cookies) {
            if (COOKIE.equals(cookie.getName()) && cookie.getValue() != null) {
                return decode(cookie.getValue());
            }
        }
        return List.of();
    }

    private static String encode(LinkedHashSet<Long> ids) {
        StringBuilder builder = new StringBuilder();
        for (Long id : ids) {
            if (builder.length() > 0) {
                builder.append('.');
            }
            builder.append(id);
        }
        return builder.toString();
    }

    private static List<Long> decode(String value) {
        List<Long> ids = new ArrayList<>();
        for (String part : value.split("\\.")) {
            try {
                long id = Long.parseLong(part);
                if (id > 0 && !ids.contains(id)) {
                    ids.add(id);
                }
            } catch (NumberFormatException ignored) {
                // Ignore damaged cookie fragments.
            }
        }
        return ids;
    }
}
