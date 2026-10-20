<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout">
    <%@ include file="/WEB-INF/fragments/sidebar.jsp" %>
    <section class="admin-content">
        <span class="eyebrow"><i class="bi bi-cart-check"></i> Fulfillment</span>
        <h1 class="h2 font-display mb-1">Customer Orders</h1>
        <p class="text-muted small mb-4">Update order status as shipments move through fulfillment stages.</p>

        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-5">
            <div class="table-responsive">
                <table class="table shop-table align-middle">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Current Status</th>
                            <th>Total</th>
                            <th>Date Placed</th>
                            <th>Status Transition</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty orders}">
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-3 d-block mb-2"></i> No customer orders recorded yet.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>
                                            <strong>#<c:out value="${order.id}"/></strong>
                                        </td>
                                        <td>
                                            <span class="status-badge status-${fn:toLowerCase(order.status)}">
                                                <i class="bi bi-circle-fill me-1" style="font-size: 0.5rem;"></i>
                                                <c:out value="${order.status}"/>
                                            </span>
                                        </td>
                                        <td class="fw-bold">&#8377;<fmt:formatNumber value="${order.total}" minFractionDigits="2"/></td>
                                        <td><small class="text-muted"><c:out value="${order.placedAt}"/></small></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="d-flex align-items-center gap-2 m-0">
                                                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                                <input type="hidden" name="orderId" value="${order.id}">
                                                
                                                <select class="form-select form-select-sm rounded-pill" name="status" style="max-width: 150px;">
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PLACED'}">
                                                            <option value="PROCESSING">Processing</option>
                                                            <option value="CANCELLED">Cancel Order</option>
                                                        </c:when>
                                                        <c:when test="${order.status == 'PROCESSING'}">
                                                            <option value="SHIPPED">Shipped</option>
                                                            <option value="CANCELLED">Cancel Order</option>
                                                        </c:when>
                                                        <c:when test="${order.status == 'SHIPPED'}">
                                                            <option value="DELIVERED">Delivered</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${order.status}"><c:out value="${order.status}"/></option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </select>
                                                
                                                <button class="btn btn-brand btn-sm rounded-pill px-3" type="submit"
                                                        ${order.status == 'DELIVERED' || order.status == 'CANCELLED' ? 'disabled' : ''}>
                                                    Update
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
