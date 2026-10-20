package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;
import com.shopsphere.service.ProductService;
import com.shopsphere.util.RecentlyViewed;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private final ProductService products = new ProductService();
    private final ProductDAO productDao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("categories", products.categories());
            request.setAttribute("featured", productDao.findFeatured(8));
            List<Product> recent = new ArrayList<>();
            for (long id : RecentlyViewed.idsFrom(request)) {
                productDao.findActiveById(id).ifPresent(recent::add);
            }
            request.setAttribute("recent", recent);
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
