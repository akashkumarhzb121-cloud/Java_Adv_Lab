package com.shopsphere.controller;

import com.shopsphere.dao.WishlistDAO;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private final WishlistDAO wishlist = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("products", wishlist.find(WebUtil.user(request).id()));
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/wishlist.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            wishlist.toggle(WebUtil.user(request).id(),
                    WebUtil.positiveId(request.getParameter("productId"), "product"));
            response.sendRedirect(request.getContextPath() + "/wishlist");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
