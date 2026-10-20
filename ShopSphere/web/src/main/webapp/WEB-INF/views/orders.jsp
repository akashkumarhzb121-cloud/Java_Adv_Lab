<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/fragments/header.jsp" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-clock-history"></i> Account Activity</span>
        <h1>My Order History</h1>
    </div>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-bag-plus me-1"></i> New Purchase
    </a>
</div>

<c:choose>
    <c:when test="${empty orders}">
        <div class="empty-state card border-0 rounded-4 p-5 shadow-sm text-center my-4">
            <div class="display-3 text-muted mb-3"><i class="bi bi-bag-x"></i></div>
            <h2 class="font-display">No orders placed yet</h2>
            <p class="text-muted mb-4">When you place orders, their real-time fulfillment status and receipts will show up here.</p>
            <div>
                <a class="btn btn-brand btn-lg" href="${pageContext.request.contextPath}/products">
                    <i class="bi bi-grid me-2"></i> Start Shopping
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-5">
            <div class="table-responsive">
                <table class="table shop-table align-middle">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date Placed</th>
                            <th>Fulfillment Status</th>
                            <th>Total Amount</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>
                                    <strong>#<c:out value="${order.id}"/></strong>
                                </td>
                                <td><c:out value="${order.placedAt}"/></td>
                                <td>
                                    <span class="status-badge status-${fn:toLowerCase(order.status)}">
                                        <i class="bi bi-circle-fill me-1" style="font-size: 0.5rem;"></i>
                                        <c:out value="${order.status}"/>
                                    </span>
                                </td>
                                <td class="fw-bold">&#8377;<fmt:formatNumber value="${order.total}" minFractionDigits="2"/></td>
                                <td class="text-end">
                                    <a class="btn btn-sm btn-outline-dark rounded-pill px-3" href="${pageContext.request.contextPath}/order?id=${order.id}">
                                        <i class="bi bi-receipt me-1"></i> Track & Details
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
