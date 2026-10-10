package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/inventory")
public class AdminInventoryServlet extends HttpServlet {
    private final ProductDAO products = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("products", products.findLowStock());
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/inventory.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            products.addStock(WebUtil.positiveId(request.getParameter("productId"), "product"),
                    WebUtil.boundedInt(request.getParameter("quantity"), "Restock quantity", 1, 1_000_000));
            response.sendRedirect(request.getContextPath() + "/admin/inventory");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
