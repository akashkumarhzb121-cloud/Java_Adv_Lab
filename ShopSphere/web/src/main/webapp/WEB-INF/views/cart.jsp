<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-cart3"></i> Review Order</span>
        <h1>Shopping Cart</h1>
    </div>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-arrow-left me-1"></i> Continue Shopping
    </a>
</div>

<c:choose>
    <c:when test="${empty items}">
        <div class="empty-state card border-0 rounded-4 p-5 shadow-sm text-center my-4">
            <div class="display-3 text-muted mb-3"><i class="bi bi-cart-x"></i></div>
            <h2 class="font-display">Your cart is currently empty</h2>
            <p class="text-muted mb-4">Discover curated lifestyle products, tech essentials and wardrobe favorites.</p>
            <div>
                <a class="btn btn-brand btn-lg" href="${pageContext.request.contextPath}/products">
                    <i class="bi bi-grid me-2"></i> Browse Products
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row g-4">
            <!-- Cart Items List -->
            <div class="col-lg-8">
                <c:forEach var="item" items="${items}">
                    <article class="cart-row d-flex align-items-center gap-3 p-3 mb-3 bg-white border border-light-subtle rounded-4 shadow-sm">
                        <img class="rounded-3 object-fit-cover" src="<c:out value='${item.product.imageUrl}'/>"
                             alt="<c:out value='${item.product.name}'/>" style="width: 100px; height: 100px;"
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/product-placeholder.svg'">
                        
                        <div class="flex-grow-1">
                            <span class="badge bg-light text-muted small"><c:out value="${item.product.categoryName}"/></span>
                            <h2 class="h6 font-display my-1">
                                <a href="${pageContext.request.contextPath}/product?id=${item.product.id}" class="text-dark">
                                    <c:out value="${item.product.name}"/>
                                </a>
                            </h2>
                            <p class="text-muted small mb-2">₹<fmt:formatNumber value="${item.product.salePrice}" minFractionDigits="2"/> each</p>
                            
                            <div class="d-flex align-items-center gap-2 flex-wrap">
                                <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex align-items-center gap-2 m-0">
                                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="productId" value="${item.product.id}">
                                    
                                    <div class="qty-stepper">
                                        <button type="button" class="btn-minus"><i class="bi bi-dash"></i></button>
                                        <input type="number" name="quantity" min="1" max="99" value="${item.quantity}" aria-label="Quantity">
                                        <button type="button" class="btn-plus"><i class="bi bi-plus"></i></button>
                                    </div>
                                    <button class="btn btn-outline-secondary btn-sm rounded-pill" type="submit" title="Update Quantity">
                                        <i class="bi bi-arrow-repeat"></i>
                                    </button>
                                </form>
                                
                                <form action="${pageContext.request.contextPath}/cart" method="post" class="m-0">
                                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="productId" value="${item.product.id}">
                                    <button class="btn btn-link text-danger btn-sm p-0 ms-2 text-decoration-none" type="submit">
                                        <i class="bi bi-trash3 me-1"></i> Remove
                                    </button>
                                </form>
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <span class="text-muted small d-block">Subtotal</span>
                            <strong class="fs-5 text-dark">₹<fmt:formatNumber value="${item.lineTotal}" minFractionDigits="2"/></strong>
                        </div>
                    </article>
                </c:forEach>
            </div>

            <!-- Sticky Order Summary Card -->
            <div class="col-lg-4">
                <aside class="card border-0 rounded-4 p-4 shadow-sm bg-white sticky-top" style="top: 90px;">
                    <h2 class="h5 font-display mb-3">Order Summary</h2>
                    
                    <div class="summary-line py-2 d-flex justify-content-between">
                        <span class="text-secondary">Subtotal</span>
                        <strong class="text-dark">₹<fmt:formatNumber value="${subtotal}" minFractionDigits="2"/></strong>
                    </div>
                    
                    <div class="summary-line py-2 d-flex justify-content-between">
                        <span class="text-secondary">Estimated Shipping</span>
                        <span class="text-success fw-bold">FREE</span>
                    </div>

                    <hr class="my-3">
                    
                    <div class="summary-line py-2 d-flex justify-content-between align-items-baseline">
                        <span class="fs-6 fw-bold">Estimated Total</span>
                        <strong class="fs-4 text-brand">₹<fmt:formatNumber value="${subtotal}" minFractionDigits="2"/></strong>
                    </div>

                    <div class="alert alert-info py-2 px-3 small rounded-3 mt-3 mb-4">
                        <i class="bi bi-info-circle me-1"></i> Coupon discounts are calculated and applied at checkout.
                    </div>

                    <a class="btn btn-brand btn-lg w-100 shadow" href="${pageContext.request.contextPath}/checkout">
                        Proceed to Checkout <i class="bi bi-arrow-right ms-1"></i>
                    </a>

                    <div class="mt-4 pt-3 border-top text-center text-muted small">
                        <i class="bi bi-shield-check text-success me-1"></i> 256-bit SSL Encrypted Checkout
                    </div>
                </aside>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
