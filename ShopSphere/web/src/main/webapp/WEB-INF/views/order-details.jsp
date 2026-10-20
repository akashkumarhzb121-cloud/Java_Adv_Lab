<%@ include file="/WEB-INF/fragments/header.jsp" %>

<c:if test="${param.placed == '1' || placed}">
    <!-- Celebratory Order Placement Card with Animated Checkmark -->
    <div class="card border-0 rounded-4 p-5 shadow text-center bg-white mb-4 reveal">
        <div class="checkmark-circle mx-auto">
            <div class="background"></div>
            <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
            </svg>
        </div>
        <span class="eyebrow"><i class="bi bi-patch-check-fill"></i> Order Confirmed</span>
        <h1 class="display-6 font-display mt-2 mb-2">Thank you for your order!</h1>
        <p class="text-muted lead fs-6 mb-3">Your transaction has been authorized and your order reference is <strong>#<c:out value="${order.id}"/></strong>.</p>
        <div>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-dark rounded-pill px-4 me-2">
                <i class="bi bi-box-seam me-1"></i> View All Orders
            </a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-brand rounded-pill px-4">
                <i class="bi bi-bag me-1"></i> Continue Shopping
            </a>
        </div>
    </div>
</c:if>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-truck"></i> Live Tracking</span>
        <h1>Order #<c:out value="${order.id}"/></h1>
        <p class="text-muted small mb-0">Placed on <c:out value="${order.placedAt}"/></p>
    </div>
    <span class="status-badge status-${fn:toLowerCase(order.status)} fs-6 px-3 py-2">
        <i class="bi bi-circle-fill me-1" style="font-size: 0.5rem;"></i> <c:out value="${order.status}"/>
    </span>
</div>

<!-- Animated Status Timeline -->
<div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-4">
    <div class="timeline-tracker">
        <!-- Step 1: Placed -->
        <div class="timeline-node ${order.status != null ? 'active completed' : ''}">
            <div class="node-circle"><i class="bi bi-cart-check"></i></div>
            <span class="node-label">Placed</span>
        </div>
        <!-- Step 2: Processing -->
        <div class="timeline-node ${order.status == 'PROCESSING' || order.status == 'SHIPPED' || order.status == 'DELIVERED' ? 'active completed' : ''}">
            <div class="node-circle"><i class="bi bi-gear"></i></div>
            <span class="node-label">Processing</span>
        </div>
        <!-- Step 3: Shipped -->
        <div class="timeline-node ${order.status == 'SHIPPED' || order.status == 'DELIVERED' ? 'active completed' : ''}">
            <div class="node-circle"><i class="bi bi-truck"></i></div>
            <span class="node-label">Shipped</span>
        </div>
        <!-- Step 4: Delivered -->
        <div class="timeline-node ${order.status == 'DELIVERED' ? 'active completed' : ''}">
            <div class="node-circle"><i class="bi bi-house-check"></i></div>
            <span class="node-label">Delivered</span>
        </div>
    </div>
</div>

<!-- Order Items & Invoice Details -->
<div class="row g-4 mb-5">
    <div class="col-lg-8">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white">
            <h2 class="h5 font-display mb-3">Purchased Items</h2>
            <div class="table-responsive">
                <table class="table shop-table align-middle">
                    <thead>
                        <tr>
                            <th>Item Description</th>
                            <th>Unit Price</th>
                            <th>Qty</th>
                            <th class="text-end">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td>
                                    <strong><c:out value="${item.productName}"/></strong>
                                </td>
                                <td>₹<fmt:formatNumber value="${item.unitPrice}" minFractionDigits="2"/></td>
                                <td><c:out value="${item.quantity}"/></td>
                                <td class="text-end fw-bold">₹<fmt:formatNumber value="${item.lineTotal}" minFractionDigits="2"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white">
            <h2 class="h5 font-display mb-3">Payment Summary</h2>
            
            <div class="summary-line py-2 d-flex justify-content-between">
                <span class="text-secondary">Subtotal</span>
                <strong class="text-dark">₹<fmt:formatNumber value="${order.subtotal}" minFractionDigits="2"/></strong>
            </div>

            <c:if test="${order.discount gt 0}">
                <div class="summary-line py-2 d-flex justify-content-between text-success">
                    <span>Voucher Discount</span>
                    <strong>-₹<fmt:formatNumber value="${order.discount}" minFractionDigits="2"/></strong>
                </div>
            </c:if>

            <div class="summary-line py-2 d-flex justify-content-between">
                <span class="text-secondary">Shipping</span>
                <span class="text-success fw-bold">FREE</span>
            </div>

            <hr class="my-3">

            <div class="summary-line py-2 d-flex justify-content-between align-items-baseline">
                <span class="fw-bold fs-6">Grand Total</span>
                <strong class="fs-4 text-brand">₹<fmt:formatNumber value="${order.total}" minFractionDigits="2"/></strong>
            </div>

            <div class="mt-4 pt-3 border-top">
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-dark w-100 rounded-pill">
                    <i class="bi bi-arrow-left me-1"></i> All Orders
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
