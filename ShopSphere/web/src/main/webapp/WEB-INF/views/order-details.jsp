<%@ include file="/WEB-INF/fragments/header.jsp" %>
<c:if test="${placed}"><div class="alert alert-success">Order placed successfully. Your reference is <strong>#<c:out value="${orderId}"/></strong>.</div></c:if>
<div class="section-heading"><div><span class="eyebrow">Order tracking</span><h1>Order #<c:out value="${order.id}"/></h1></div><span class="status-badge"><c:out value="${order.status}"/></span></div>
<div class="timeline"><span class="timeline-step active">Placed</span><span class="timeline-step ${order.status == 'PROCESSING' || order.status == 'SHIPPED' || order.status == 'DELIVERED' ? 'active' : ''}">Processing</span><span class="timeline-step ${order.status == 'SHIPPED' || order.status == 'DELIVERED' ? 'active' : ''}">Shipped</span><span class="timeline-step ${order.status == 'DELIVERED' ? 'active' : ''}">Delivered</span></div>
<div class="card p-3 p-md-4"><h2>Items</h2><c:forEach var="item" items="${items}"><div class="summary-line py-2"><span><c:out value="${item.productName}"/> × <c:out value="${item.quantity}"/></span><strong>₹<fmt:formatNumber value="${item.lineTotal}" minFractionDigits="2"/></strong></div></c:forEach>
    <hr><div class="summary-line"><span>Subtotal</span><strong>₹<fmt:formatNumber value="${order.subtotal}" minFractionDigits="2"/></strong></div>
    <div class="summary-line"><span>Discount</span><strong>-₹<fmt:formatNumber value="${order.discount}" minFractionDigits="2"/></strong></div>
    <div class="summary-line"><span>Total</span><strong>₹<fmt:formatNumber value="${order.total}" minFractionDigits="2"/></strong></div>
</div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
