<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout">
    <%@ include file="/WEB-INF/fragments/sidebar.jsp" %>
    <section class="admin-content">
        <span class="eyebrow"><i class="bi bi-ticket-perforated"></i> Marketing & Discounts</span>
        <h1 class="h2 font-display mb-1">Promotional Coupons</h1>
        <p class="text-muted small mb-4">Create percentage discount coupons with minimum order rules.</p>

        <!-- Create Coupon Form -->
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-4">
            <h2 class="h5 font-display mb-3"><i class="bi bi-tag me-2 text-brand"></i>Issue New Voucher</h2>
            <form action="${pageContext.request.contextPath}/admin/coupons" method="post" class="row g-3">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Coupon Code</label>
                    <input class="form-control" name="code" required maxlength="40" placeholder="e.g. FESTIVE20" style="text-transform: uppercase;">
                </div>
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Discount Percentage (%)</label>
                    <input class="form-control" name="discountPercent" type="number" min="0.01" max="100" step="0.01" required placeholder="15">
                </div>
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Minimum Order Amount (₹)</label>
                    <input class="form-control" name="minimumOrder" type="number" min="0" step="0.01" value="500.00" required>
                </div>
                <div class="col-12 mt-2">
                    <button class="btn btn-brand" type="submit">
                        <i class="bi bi-plus-lg me-1"></i> Issue Coupon (Valid 1 Year)
                    </button>
                </div>
            </form>
        </div>

        <!-- Coupons Table -->
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-5">
            <h2 class="h5 font-display mb-3">Active Promotional Codes</h2>
            <div class="table-responsive">
                <table class="table shop-table align-middle">
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Discount</th>
                            <th>Minimum Spend</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="coupon" items="${coupons}">
                            <tr>
                                <td><span class="font-monospace fw-bold fs-6"><c:out value="${coupon.code}"/></span></td>
                                <td><span class="badge bg-warning-subtle text-warning-emphasis"><c:out value="${coupon.discountPercent}"/>% OFF</span></td>
                                <td>₹<fmt:formatNumber value="${coupon.minimumOrder}" minFractionDigits="2"/></td>
                                <td>
                                    <span class="badge ${coupon.active ? 'bg-success-subtle text-success' : 'bg-secondary-subtle text-secondary'}">
                                        <c:out value="${coupon.active ? 'Active' : 'Inactive'}"/>
                                    </span>
                                </td>
                                <td class="text-end">
                                    <form action="${pageContext.request.contextPath}/admin/coupons" method="post" class="d-inline">
                                        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                        <input type="hidden" name="action" value="setActive">
                                        <input type="hidden" name="id" value="${coupon.id}">
                                        <input type="hidden" name="active" value="${coupon.active ? 'false' : 'true'}">
                                        <button class="btn btn-outline-dark btn-sm rounded-pill px-3" type="submit">
                                            <c:out value="${coupon.active ? 'Deactivate' : 'Activate'}"/>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
