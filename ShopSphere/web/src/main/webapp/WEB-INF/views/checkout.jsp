<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-shield-lock-fill"></i> Step 2 of 2</span>
        <h1>Secure Checkout</h1>
    </div>
    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-arrow-left me-1"></i> Return to Cart
    </a>
</div>

<div class="row g-4 mb-5">
    <!-- Checkout Form Column -->
    <div class="col-lg-7">
        <!-- Saved Addresses (if available) -->
        <c:if test="${not empty addresses}">
            <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-4">
                <h2 class="h5 font-display mb-3"><i class="bi bi-bookmark-check me-2 text-brand"></i>Choose Saved Address</h2>
                <div class="row g-2">
                    <c:forEach var="address" items="${addresses}">
                        <div class="col-md-6">
                            <button type="button" class="btn saved-address w-100 text-start p-3 rounded-4 border bg-white shadow-sm transition-all h-100"
                                    data-label="<c:out value='${address.label}'/>"
                                    data-line1="<c:out value='${address.line1}'/>"
                                    data-line2="<c:out value='${address.line2}'/>"
                                    data-city="<c:out value='${address.city}'/>"
                                    data-state="<c:out value='${address.state}'/>"
                                    data-postal-code="<c:out value='${address.postalCode}'/>"
                                    data-country="<c:out value='${address.country}'/>">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <strong class="text-dark"><c:out value="${address.label}"/></strong>
                                    <span class="badge bg-light text-muted small">Select</span>
                                </div>
                                <p class="small text-muted mb-0"><c:out value="${address.line1}"/>, <c:out value="${address.city}"/></p>
                            </button>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/checkout" method="post" class="checkout-form card border-0 rounded-4 p-4 shadow-sm bg-white">
            <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
            
            <h2 class="h5 font-display mb-3"><i class="bi bi-geo-alt-fill me-2 text-brand"></i>Delivery Address</h2>
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Address Label</label>
                    <input class="form-control" name="label" value="Home" required maxlength="40" placeholder="e.g. Home, Work">
                </div>
                <div class="col-md-8">
                    <label class="form-label small fw-bold">Address Line 1</label>
                    <input class="form-control" name="line1" required maxlength="180" placeholder="Street, Flat/House No." autocomplete="address-line1">
                </div>
                <div class="col-12">
                    <label class="form-label small fw-bold">Address Line 2 (Optional)</label>
                    <input class="form-control" name="line2" maxlength="180" placeholder="Apartment, Landmark, Suite" autocomplete="address-line2">
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold">City</label>
                    <input class="form-control" name="city" required maxlength="100" autocomplete="address-level2">
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold">State</label>
                    <input class="form-control" name="state" required maxlength="100" autocomplete="address-level1">
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold">Postal Code (PIN)</label>
                    <input class="form-control" name="postalCode" required maxlength="20" autocomplete="postal-code">
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold">Country</label>
                    <input class="form-control" name="country" value="India" required maxlength="80" autocomplete="country-name">
                </div>
            </div>

            <h2 class="h5 font-display mb-3"><i class="bi bi-credit-card-2-front-fill me-2 text-brand"></i>Payment Method</h2>
            <div class="vstack gap-2 mb-4">
                <label class="choice-card p-3 border rounded-4 d-flex align-items-start gap-3 cursor-pointer">
                    <input class="form-check-input mt-1" type="radio" name="paymentMethod" value="MOCK_CARD" checked>
                    <div>
                        <strong class="d-block text-dark"><i class="bi bi-credit-card me-1"></i> Simulated Card Payment</strong>
                        <small class="text-muted">Safe educational simulation. No real banking credentials or credit cards are charged.</small>
                    </div>
                </label>
                <label class="choice-card p-3 border rounded-4 d-flex align-items-start gap-3 cursor-pointer">
                    <input class="form-check-input mt-1" type="radio" name="paymentMethod" value="CASH_ON_DELIVERY">
                    <div>
                        <strong class="d-block text-dark"><i class="bi bi-cash-coin me-1"></i> Cash on Delivery</strong>
                        <small class="text-muted">Pay with cash or UPI at the doorstep upon physical product delivery.</small>
                    </div>
                </label>
            </div>

            <h2 class="h5 font-display mb-2"><i class="bi bi-tag-fill me-2 text-brand"></i>Promotional Voucher</h2>
            <div class="mb-4">
                <div class="input-group">
                    <input class="form-control" name="coupon" maxlength="40" placeholder="e.g. WELCOME10">
                    <button class="btn btn-outline-secondary" type="button" onclick="this.previousElementSibling.value='WELCOME10'">
                        Use WELCOME10
                    </button>
                </div>
                <small class="text-muted">Try using <strong>WELCOME10</strong> for 10% off orders above ₹500.</small>
            </div>

            <button class="btn btn-brand btn-lg w-100 shadow py-3" type="submit">
                <i class="bi bi-lock-fill me-1"></i> Authorize & Place Order
            </button>
        </form>
    </div>

    <!-- Order Items Summary Column -->
    <div class="col-lg-5">
        <aside class="card border-0 rounded-4 p-4 shadow-sm bg-white sticky-top" style="top: 90px;">
            <h2 class="h5 font-display mb-3">Order Items (<c:out value="${fn:length(items)}"/>)</h2>
            
            <div class="items-list mb-3" style="max-height: 280px; overflow-y: auto;">
                <c:forEach var="item" items="${items}">
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom border-light">
                        <div class="d-flex align-items-center gap-2">
                            <img src="<c:out value='${item.product.imageUrl}'/>" style="width: 40px; height: 40px; object-fit: cover; border-radius: 8px;"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/product-placeholder.svg'">
                            <div>
                                <span class="d-block small fw-bold text-dark text-truncate" style="max-width: 180px;"><c:out value="${item.product.name}"/></span>
                                <small class="text-muted">Qty: <c:out value="${item.quantity}"/></small>
                            </div>
                        </div>
                        <strong class="small text-dark">₹<fmt:formatNumber value="${item.lineTotal}" minFractionDigits="2"/></strong>
                    </div>
                </c:forEach>
            </div>

            <div class="summary-line py-2 d-flex justify-content-between">
                <span class="text-secondary">Subtotal</span>
                <strong class="text-dark">₹<fmt:formatNumber value="${subtotal}" minFractionDigits="2"/></strong>
            </div>

            <div class="summary-line py-2 d-flex justify-content-between">
                <span class="text-secondary">Standard Shipping</span>
                <span class="text-success fw-bold">FREE</span>
            </div>

            <hr class="my-3">

            <div class="summary-line py-2 d-flex justify-content-between align-items-baseline">
                <span class="fw-bold">Estimated Total</span>
                <strong class="fs-4 text-brand">₹<fmt:formatNumber value="${subtotal}" minFractionDigits="2"/></strong>
            </div>

            <div class="bg-light p-3 rounded-3 small text-muted mt-3">
                <i class="bi bi-shield-check text-success me-1"></i> Order total is recalculated transactionally by the checkout service.
            </div>
        </aside>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
