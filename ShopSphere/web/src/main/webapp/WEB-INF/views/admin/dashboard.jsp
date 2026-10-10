<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout"><%@ include file="/WEB-INF/fragments/sidebar.jsp" %><section class="admin-content">
    <span class="eyebrow">ShopSphere operations</span><h1>Dashboard</h1><p class="text-muted">A quick view of store activity and fulfillment.</p>
    <div class="stats-grid">
        <div class="stat-card"><span>Gross sales</span><strong>₹<fmt:formatNumber value="${stats.sales}" minFractionDigits="2"/></strong></div>
        <div class="stat-card"><span>Orders</span><strong><c:out value="${stats.orders}"/></strong></div>
        <div class="stat-card"><span>Active products</span><strong><c:out value="${stats.products}"/></strong></div>
        <div class="stat-card"><span>Customers</span><strong><c:out value="${stats.customers}"/></strong></div>
    </div>
    <div class="alert alert-warning mt-4">Low-stock products (5 or fewer): <strong><c:out value="${stats.lowStock}"/></strong></div>
    <div class="admin-quicklinks"><a href="${pageContext.request.contextPath}/admin/orders">Review order queue →</a><a href="${pageContext.request.contextPath}/admin/products">Manage catalog →</a></div>
</section></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
