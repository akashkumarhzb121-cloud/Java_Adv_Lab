package com.shopsphere.controller;

import com.shopsphere.service.ProductService;
import com.shopsphere.dao.ReviewDAO;
import com.shopsphere.util.RecentlyViewed;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/products", "/product"})
public class ProductServlet extends HttpServlet {
    private final ProductService products = new ProductService();
    private final ReviewDAO reviews = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("categories", products.categories());
            String id = request.getParameter("id");
            if ("/product".equals(request.getServletPath()) && id != null) {
                long productId = WebUtil.positiveId(id, "product");
                var product = products.find(productId);
                if (product.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                request.setAttribute("product", product.get());
                request.setAttribute("reviews", reviews.findForProduct(productId));
                RecentlyViewed.remember(request, response, productId);
                WebUtil.csrfToken(request);
                request.getRequestDispatcher("/WEB-INF/views/product-details.jsp").forward(request, response);
                return;
            }
            request.setAttribute("products", products.browse(request.getParameter("q"),
                    request.getParameter("category"), request.getParameter("sort")));
            request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
