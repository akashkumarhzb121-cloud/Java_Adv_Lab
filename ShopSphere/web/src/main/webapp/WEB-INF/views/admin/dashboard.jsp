<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout">
    <%@ include file="/WEB-INF/fragments/sidebar.jsp" %>
    <section class="admin-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <span class="eyebrow"><i class="bi bi-speedometer2"></i> Control Center</span>
                <h1 class="h2 font-display mb-1">Store Dashboard</h1>
                <p class="text-muted small mb-0">Overview of sales, inventory thresholds, and customer orders.</p>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-brand btn-sm">
                    <i class="bi bi-plus-lg me-1"></i> Add Product
                </a>
            </div>
        </div>

        <div class="stats-grid mb-4">
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-start">
                    <span>Gross Sales</span>
                    <span class="p-2 rounded-3 bg-success-subtle text-success fs-5"><i class="bi bi-currency-rupee"></i></span>
                </div>
                <strong>&#8377;<fmt:formatNumber value="${stats.sales}" minFractionDigits="2"/></strong>
                <small class="text-success"><i class="bi bi-graph-up-arrow"></i> Real-time DB summary</small>
            </div>
            
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-start">
                    <span>Total Orders</span>
                    <span class="p-2 rounded-3 bg-primary-subtle text-primary fs-5"><i class="bi bi-box-seam"></i></span>
                </div>
                <strong><c:out value="${stats.orders}"/></strong>
                <small class="text-muted">Recorded transactions</small>
            </div>
            
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-start">
                    <span>Active Products</span>
                    <span class="p-2 rounded-3 bg-info-subtle text-info fs-5"><i class="bi bi-grid-3x3-gap"></i></span>
                </div>
                <strong><c:out value="${stats.products}"/></strong>
                <small class="text-muted">Listed in catalog</small>
            </div>
            
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-start">
                    <span>Customer Accounts</span>
                    <span class="p-2 rounded-3 bg-warning-subtle text-warning-emphasis fs-5"><i class="bi bi-people"></i></span>
                </div>
                <strong><c:out value="${stats.customers}"/></strong>
                <small class="text-muted">Registered shoppers</small>
            </div>
        </div>

        <c:choose>
            <c:when test="${stats.lowStock gt 0}">
                <div class="alert alert-warning d-flex align-items-center justify-content-between p-3 rounded-4 shadow-sm mb-4" role="alert">
                    <div class="d-flex align-items-center gap-3">
                        <i class="bi bi-exclamation-triangle-fill fs-3 text-warning"></i>
                        <div>
                            <strong class="d-block">Low-Stock Alert: <c:out value="${stats.lowStock}"/> product(s) have 5 or fewer items remaining.</strong>
                            <small class="text-muted">Restock now to prevent checkout disruptions for customers.</small>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/inventory" class="btn btn-warning btn-sm rounded-pill px-3 fw-bold">
                        Restock Inventory →
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-success d-flex align-items-center gap-3 p-3 rounded-4 shadow-sm mb-4">
                    <i class="bi bi-check-circle-fill fs-3 text-success"></i>
                    <div>
                        <strong class="d-block">Healthy Inventory Status</strong>
                        <small>All listed products have sufficient stock levels.</small>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="row g-4">
            <div class="col-md-6">
                <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
                    <h2 class="h5 font-display mb-3"><i class="bi bi-lightning-charge me-2 text-warning"></i>Quick Management</h2>
                    <div class="vstack gap-2">
                        <a href="${pageContext.request.contextPath}/admin/orders" class="p-3 border rounded-3 text-dark d-flex justify-content-between align-items-center text-decoration-none hover-bg-light">
                            <span><i class="bi bi-cart-check me-2 text-primary"></i> Process Incoming Orders</span>
                            <i class="bi bi-chevron-right text-muted"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/products" class="p-3 border rounded-3 text-dark d-flex justify-content-between align-items-center text-decoration-none hover-bg-light">
                            <span><i class="bi bi-box-seam me-2 text-success"></i> Manage Catalog Items</span>
                            <i class="bi bi-chevron-right text-muted"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/coupons" class="p-3 border rounded-3 text-dark d-flex justify-content-between align-items-center text-decoration-none hover-bg-light">
                            <span><i class="bi bi-ticket-perforated me-2 text-danger"></i> Configure Discount Vouchers</span>
                            <i class="bi bi-chevron-right text-muted"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
                    <h2 class="h5 font-display mb-3"><i class="bi bi-cpu me-2 text-info"></i>RTU Enterprise Integrations</h2>
                    <p class="text-muted small">ShopSphere links standard browser commerce with advanced Java modules:</p>
                    <div class="d-flex flex-wrap gap-2">
                        <span class="badge bg-light text-dark p-2 border"><i class="bi bi-diagram-3 me-1"></i> Java RMI Registry</span>
                        <span class="badge bg-light text-dark p-2 border"><i class="bi bi-hdd-network me-1"></i> Socket / ServerSocket</span>
                        <span class="badge bg-light text-dark p-2 border"><i class="bi bi-window me-1"></i> Swing Desktop GUI</span>
                        <span class="badge bg-light text-dark p-2 border"><i class="bi bi-file-earmark-code me-1"></i> Object Serialization</span>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
