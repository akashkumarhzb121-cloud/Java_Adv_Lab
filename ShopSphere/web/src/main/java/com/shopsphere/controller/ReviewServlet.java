package com.shopsphere.controller;

import com.shopsphere.dao.ReviewDAO;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {
    private final ReviewDAO reviews = new ReviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            long productId = WebUtil.positiveId(request.getParameter("productId"), "product");
            String title = request.getParameter("title");
            String body = request.getParameter("body");
            if ((title != null && title.length() > 120) || (body != null && body.length() > 2000)) {
                throw new IllegalArgumentException("Review title or text is too long.");
            }
            reviews.save(WebUtil.user(request).id(), productId,
                    WebUtil.boundedInt(request.getParameter("rating"), "Rating", 1, 5), title, body);
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId + "#reviews");
        } catch (IllegalArgumentException exception) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, exception.getMessage());
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
