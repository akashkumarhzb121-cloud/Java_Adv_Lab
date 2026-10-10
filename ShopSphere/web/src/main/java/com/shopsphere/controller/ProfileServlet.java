package com.shopsphere.controller;

import com.shopsphere.dao.AddressDAO;
import com.shopsphere.dao.ProfileDAO;
import com.shopsphere.model.User;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/account/profile")
public class ProfileServlet extends HttpServlet {
    private final ProfileDAO profiles = new ProfileDAO();
    private final AddressDAO addresses = new AddressDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("addresses", addresses.findForUser(WebUtil.user(request).id()));
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            User current = WebUtil.user(request);
            String action = request.getParameter("action");
            if ("saveProfile".equals(action)) {
                profiles.update(current.id(), request.getParameter("fullName"), request.getParameter("phone"));
                request.getSession().setAttribute("user", new User(current.id(),
                        request.getParameter("fullName").trim(), current.email(), current.role(),
                        request.getParameter("phone")));
                request.setAttribute("notice", "Your profile has been updated.");
            } else if ("addAddress".equals(action)) {
                addresses.add(current.id(), request.getParameter("label"), request.getParameter("line1"),
                        request.getParameter("line2"), request.getParameter("city"),
                        request.getParameter("state"), request.getParameter("postalCode"),
                        request.getParameter("country"));
                request.setAttribute("notice", "Your address has been saved.");
            } else if ("deleteAddress".equals(action)) {
                addresses.delete(current.id(), WebUtil.positiveId(request.getParameter("addressId"), "address"));
                request.setAttribute("notice", "The address has been removed.");
            } else {
                throw new IllegalArgumentException("Choose a valid profile action.");
            }
            doGet(request, response);
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
