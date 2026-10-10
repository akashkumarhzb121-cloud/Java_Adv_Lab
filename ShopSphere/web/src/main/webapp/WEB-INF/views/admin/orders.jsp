<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout"><%@ include file="/WEB-INF/fragments/sidebar.jsp" %><section class="admin-content">
    <span class="eyebrow">Fulfillment</span><h1>Orders</h1>
    <div class="table-responsive"><table class="table shop-table align-middle"><thead><tr><th>Order</th><th>Status</th><th>Total</th><th>Placed</th><th>Update status</th></tr></thead><tbody>
        <c:forEach var="order" items="${orders}"><tr><td>#<c:out value="${order.id}"/></td><td><span class="status-badge"><c:out value="${order.status}"/></span></td><td>₹<fmt:formatNumber value="${order.total}"/></td><td><c:out value="${order.placedAt}"/></td><td>
            <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="d-flex gap-2"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="orderId" value="${order.id}">
                <select class="form-select form-select-sm" name="status">
                    <c:choose>
                        <c:when test="${order.status == 'PLACED'}"><option value="PROCESSING">Processing</option><option value="CANCELLED">Cancelled</option></c:when>
                        <c:when test="${order.status == 'PROCESSING'}"><option value="SHIPPED">Shipped</option><option value="CANCELLED">Cancelled</option></c:when>
                        <c:when test="${order.status == 'SHIPPED'}"><option value="DELIVERED">Delivered</option></c:when>
                        <c:otherwise><option value="${order.status}"><c:out value="${order.status}"/></option></c:otherwise>
                    </c:choose>
                </select><button class="btn btn-outline-dark btn-sm" type="submit" ${order.status == 'DELIVERED' || order.status == 'CANCELLED' ? 'disabled' : ''}>Save</button>
            </form></td></tr></c:forEach>
    </tbody></table></div>
</section></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
