package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.service.ProductService;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {
    private final ProductService products = new ProductService();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("products", productDAO.findAllForAdmin());
            request.setAttribute("categories", products.categories());
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            if ("setActive".equals(request.getParameter("action"))) {
                productDAO.setActive(WebUtil.positiveId(request.getParameter("id"), "product"),
                        "true".equals(request.getParameter("active")));
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            long id = request.getParameter("id") == null || request.getParameter("id").isBlank()
                    ? 0 : WebUtil.positiveId(request.getParameter("id"), "product");
            long category = WebUtil.positiveId(request.getParameter("categoryId"), "category");
            String name = request.getParameter("name");
            String slug = request.getParameter("slug");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            if (name == null || name.isBlank() || name.length() > 180 || slug == null || slug.isBlank()
                    || slug.length() > 200 || description == null || description.isBlank()
                    || (imageUrl != null && imageUrl.length() > 1000)) {
                throw new IllegalArgumentException("Complete all required product fields.");
            }
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            BigDecimal discount = new BigDecimal(request.getParameter("discountPercent"));
            if (price.signum() < 0 || discount.signum() < 0 || discount.compareTo(new BigDecimal("100")) > 0) {
                throw new IllegalArgumentException("Price and discount are outside the allowed range.");
            }
            int stock = WebUtil.boundedInt(request.getParameter("stock"), "Stock", 0, 1_000_000);
            boolean active = !"false".equals(request.getParameter("active"));
            productDAO.save(id, category, name.trim(), slug.trim(), description.trim(), imageUrl,
                    price, discount, stock, active);
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (NumberFormatException exception) {
            request.setAttribute("error", "Enter valid numeric product values.");
            doGet(request, response);
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
