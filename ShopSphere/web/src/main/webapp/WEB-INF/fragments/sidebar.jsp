<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<aside class="admin-sidebar">
    <div class="sidebar-title">Management</div>
    <a href="${pageContext.request.contextPath}/admin">Overview</a>
    <a href="${pageContext.request.contextPath}/admin/products">Products & inventory</a>
    <a href="${pageContext.request.contextPath}/admin/inventory">Low stock / restock</a>
    <a href="${pageContext.request.contextPath}/admin/categories">Categories</a>
    <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
    <a href="${pageContext.request.contextPath}/admin/users">Customers</a>
    <a href="${pageContext.request.contextPath}/admin/coupons">Coupons</a>
</aside>
