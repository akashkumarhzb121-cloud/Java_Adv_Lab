<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="section-heading"><div><span class="eyebrow">All in one place</span><h1>Your orders</h1></div></div>
<c:choose><c:when test="${empty orders}"><div class="empty-state"><h2>No orders yet</h2><a class="btn btn-brand" href="${pageContext.request.contextPath}/products">Find something you love</a></div></c:when>
<c:otherwise><div class="table-responsive"><table class="table shop-table align-middle"><thead><tr><th>Order</th><th>Placed</th><th>Status</th><th>Total</th><th></th></tr></thead><tbody>
    <c:forEach var="order" items="${orders}"><tr><td>#<c:out value="${order.id}"/></td><td><c:out value="${order.placedAt}"/></td>
        <td><span class="status-badge"><c:out value="${order.status}"/></span></td><td>₹<fmt:formatNumber value="${order.total}" minFractionDigits="2"/></td>
        <td><a href="${pageContext.request.contextPath}/order?id=${order.id}">Details</a></td></tr></c:forEach>
</tbody></table></div></c:otherwise></c:choose>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
