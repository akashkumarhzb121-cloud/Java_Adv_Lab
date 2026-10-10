<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="section-heading"><div><span class="eyebrow">Your picks</span><h1>Shopping cart</h1></div><a href="${pageContext.request.contextPath}/products">Continue shopping</a></div>
<c:choose>
    <c:when test="${empty items}"><div class="empty-state"><h2>Your cart is ready for something good</h2><p>Browse the collection and add a few favorites.</p><a class="btn btn-brand" href="${pageContext.request.contextPath}/products">Explore products</a></div></c:when>
    <c:otherwise><div class="row g-4"><div class="col-lg-8">
        <c:forEach var="item" items="${items}">
            <article class="cart-row">
                <img src="<c:out value='${item.product.imageUrl}'/>" alt="<c:out value='${item.product.name}'/>">
                <div class="flex-grow-1"><h2><a href="${pageContext.request.contextPath}/product?id=${item.product.id}"><c:out value="${item.product.name}"/></a></h2>
                    <p class="text-muted mb-2">₹<fmt:formatNumber value="${item.product.salePrice}" minFractionDigits="2"/> each</p>
                    <div class="d-flex gap-2 flex-wrap">
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex gap-2">
                            <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="update"><input type="hidden" name="productId" value="${item.product.id}">
                            <input class="form-control quantity-input" type="number" name="quantity" min="1" max="99" value="${item.quantity}" aria-label="Quantity">
                            <button class="btn btn-outline-dark btn-sm" type="submit">Update</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="remove"><input type="hidden" name="productId" value="${item.product.id}">
                            <button class="btn btn-link text-danger btn-sm" type="submit">Remove</button>
                        </form>
                    </div>
                </div>
                <strong>₹<fmt:formatNumber value="${item.lineTotal}" minFractionDigits="2"/></strong>
            </article>
        </c:forEach>
    </div><div class="col-lg-4"><aside class="summary-card"><h2>Order summary</h2><div class="summary-line"><span>Subtotal</span><strong>₹<fmt:formatNumber value="${subtotal}" minFractionDigits="2"/></strong></div>
        <small class="text-muted">Shipping and eligible discounts are confirmed at checkout.</small><a class="btn btn-brand w-100 mt-4" href="${pageContext.request.contextPath}/checkout">Continue to checkout</a>
    </aside></div></div></c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
