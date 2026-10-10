package com.shopsphere.controller;

import com.shopsphere.dao.CouponDAO;
import com.shopsphere.util.WebUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/admin/coupons")
public class AdminCouponServlet extends HttpServlet {
    private final CouponDAO coupons = new CouponDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("coupons", coupons.findAll());
            WebUtil.csrfToken(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/coupons.jsp").forward(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            if ("setActive".equals(request.getParameter("action"))) {
                coupons.setActive(WebUtil.positiveId(request.getParameter("id"), "coupon"),
                        "true".equals(request.getParameter("active")));
            } else {
                coupons.add(request.getParameter("code"),
                        new BigDecimal(request.getParameter("discountPercent")),
                        new BigDecimal(request.getParameter("minimumOrder")));
            }
            response.sendRedirect(request.getContextPath() + "/admin/coupons");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", "Enter a valid coupon code and numeric values.");
            doGet(request, response);
        } catch (SQLException exception) {
            WebUtil.databaseError(this, request, response, exception);
        }
    }
}
