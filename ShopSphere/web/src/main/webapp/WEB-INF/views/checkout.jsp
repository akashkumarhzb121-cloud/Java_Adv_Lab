<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="section-heading"><div><span class="eyebrow">Almost yours</span><h1>Secure checkout</h1></div></div>
<div class="row g-4"><div class="col-lg-7"><form action="${pageContext.request.contextPath}/checkout" method="post" class="checkout-form">
    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
    <h2>Delivery address</h2><div class="row g-3">
        <div class="col-md-4"><label>Label<input class="form-control" name="label" value="Home" required maxlength="40"></label></div>
        <div class="col-md-8"><label>Address line 1<input class="form-control" name="line1" required maxlength="180" autocomplete="address-line1"></label></div>
        <div class="col-12"><label>Address line 2<input class="form-control" name="line2" maxlength="180" autocomplete="address-line2"></label></div>
        <div class="col-md-6"><label>City<input class="form-control" name="city" required maxlength="100" autocomplete="address-level2"></label></div>
        <div class="col-md-6"><label>State<input class="form-control" name="state" required maxlength="100" autocomplete="address-level1"></label></div>
        <div class="col-md-6"><label>Postal code<input class="form-control" name="postalCode" required maxlength="20" autocomplete="postal-code"></label></div>
        <div class="col-md-6"><label>Country<input class="form-control" name="country" value="India" required maxlength="80" autocomplete="country-name"></label></div>
    </div>
    <h2 class="mt-4">Payment</h2><div class="vstack gap-2">
        <label class="choice-card"><input type="radio" name="paymentMethod" value="MOCK_CARD" checked> Mock card payment <small>Simulated payment only — no card details are collected.</small></label>
        <label class="choice-card"><input type="radio" name="paymentMethod" value="CASH_ON_DELIVERY"> Cash on delivery</label>
    </div>
    <div class="mt-4"><label>Coupon code (optional)<input class="form-control" name="coupon" maxlength="40" placeholder="WELCOME10"></label></div>
    <button class="btn btn-brand btn-lg mt-4" type="submit">Place order</button>
</form></div><div class="col-lg-5"><aside class="summary-card"><h2>Items</h2>
    <c:forEach var="item" items="${items}"><div class="summary-line"><span><c:out value="${item.product.name}"/> × <c:out value="${item.quantity}"/></span><strong>₹<fmt:formatNumber value="${item.lineTotal}" minFractionDigits="2"/></strong></div></c:forEach>
    <hr><div class="summary-line"><span>Subtotal</span><strong>₹<fmt:formatNumber value="${subtotal}" minFractionDigits="2"/></strong></div>
    <small class="text-muted">The final total is calculated and inventory reserved on the server at order placement.</small>
</aside></div></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
