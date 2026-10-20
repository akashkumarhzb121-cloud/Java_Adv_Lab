<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<aside class="admin-sidebar">
    <div class="sidebar-title">Store Operations</div>
    <a href="${pageContext.request.contextPath}/admin" class="${pageContext.request.servletPath == '/admin' ? 'active' : ''}">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin/orders" class="${pageContext.request.servletPath == '/admin/orders' ? 'active' : ''}">
        <i class="bi bi-cart-check"></i> Orders Queue
    </a>
    <a href="${pageContext.request.contextPath}/admin/products" class="${pageContext.request.servletPath == '/admin/products' ? 'active' : ''}">
        <i class="bi bi-box-seam"></i> Products Catalog
    </a>
    <a href="${pageContext.request.contextPath}/admin/inventory" class="${pageContext.request.servletPath == '/admin/inventory' ? 'active' : ''}">
        <i class="bi bi-exclamation-triangle"></i> Low Stock Restock
    </a>
    <a href="${pageContext.request.contextPath}/admin/categories" class="${pageContext.request.servletPath == '/admin/categories' ? 'active' : ''}">
        <i class="bi bi-folder"></i> Categories
    </a>
    <a href="${pageContext.request.contextPath}/admin/users" class="${pageContext.request.servletPath == '/admin/users' ? 'active' : ''}">
        <i class="bi bi-people"></i> Customers
    </a>
    <a href="${pageContext.request.contextPath}/admin/coupons" class="${pageContext.request.servletPath == '/admin/coupons' ? 'active' : ''}">
        <i class="bi bi-ticket-perforated"></i> Discount Coupons
    </a>

    <div class="sidebar-title mt-3">Navigation</div>
    <a href="${pageContext.request.contextPath}/home" class="text-secondary">
        <i class="bi bi-arrow-left-circle"></i> Back to Store
    </a>
</aside>
