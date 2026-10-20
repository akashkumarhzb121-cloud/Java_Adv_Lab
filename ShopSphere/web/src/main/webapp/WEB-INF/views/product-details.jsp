<%@ include file="/WEB-INF/fragments/header.jsp" %>
<%@ taglib prefix="ss" tagdir="/WEB-INF/tags" %>

<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb small">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door"></i> Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Shop</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products?category=${product.categoryId}"><c:out value="${product.categoryName}"/></a></li>
        <li class="breadcrumb-item active" aria-current="page"><c:out value="${product.name}"/></li>
    </ol>
</nav>

<div class="row g-5 product-detail reveal">
    <!-- Product Media -->
    <div class="col-lg-6">
        <div class="detail-image-card position-relative">
            <img class="detail-image w-100" src="<c:out value='${product.imageUrl}'/>" alt="<c:out value='${product.name}'/>"
                 onerror="this.src='${pageContext.request.contextPath}/assets/images/product-placeholder.svg'">
            <c:if test="${product.discountPercent gt 0}">
                <span class="discount-pill fs-6 py-2 px-3">
                    <i class="bi bi-fire me-1"></i> <fmt:formatNumber value="${product.discountPercent}" maxFractionDigits="0"/>% OFF
                </span>
            </c:if>
        </div>
    </div>

    <!-- Product Purchasing Info -->
    <div class="col-lg-6 d-flex flex-column justify-content-center">
        <div class="mb-2">
            <span class="badge bg-secondary-subtle text-dark-emphasis px-3 py-1 rounded-pill">
                <c:out value="${product.categoryName}"/>
            </span>
        </div>
        <h1 class="font-display mb-2"><c:out value="${product.name}"/></h1>
        
        <div class="d-flex align-items-center gap-3 mb-3">
            <ss:rating value="${product.rating}" count="${product.reviewCount}"/>
            <span class="text-muted">·</span>
            <span class="text-muted small"><c:out value="${product.reviewCount}"/> verified reviews</span>
        </div>

        <div class="d-flex align-items-baseline gap-3 mb-3">
            <span class="detail-price">₹<fmt:formatNumber value="${product.salePrice}" minFractionDigits="2"/></span>
            <c:if test="${product.discountPercent gt 0}">
                <del class="text-muted fs-5">₹<fmt:formatNumber value="${product.price}"/></del>
                <span class="badge bg-danger-subtle text-danger fw-bold rounded-pill">Save ₹<fmt:formatNumber value="${product.price - product.salePrice}" minFractionDigits="2"/></span>
            </c:if>
        </div>

        <p class="detail-description mb-4 lead fs-6"><c:out value="${product.description}"/></p>

        <!-- Availability -->
        <div class="mb-4">
            <c:choose>
                <c:when test="${product.stock gt 5}">
                    <span class="badge bg-success-subtle text-success px-3 py-2 rounded-pill fw-semibold">
                        <i class="bi bi-check-circle-fill me-1"></i> In stock (<c:out value="${product.stock}"/> units available)
                    </span>
                </c:when>
                <c:when test="${product.stock gt 0}">
                    <span class="badge bg-warning-subtle text-warning-emphasis px-3 py-2 rounded-pill fw-semibold">
                        <i class="bi bi-exclamation-circle-fill me-1"></i> Only <c:out value="${product.stock}"/> left in stock!
                    </span>
                </c:when>
                <c:otherwise>
                    <span class="badge bg-danger-subtle text-danger px-3 py-2 rounded-pill fw-semibold">
                        <i class="bi bi-x-circle-fill me-1"></i> Out of stock
                    </span>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Add to Cart Form with Stepper -->
        <div class="d-flex flex-wrap align-items-center gap-3 mb-4">
            <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex align-items-center gap-3">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="${product.id}">
                
                <div class="qty-stepper">
                    <button type="button" class="btn-minus" aria-label="Decrease quantity"><i class="bi bi-dash"></i></button>
                    <input type="number" name="quantity" min="1" max="99" value="1" aria-label="Quantity">
                    <button type="button" class="btn-plus" aria-label="Increase quantity"><i class="bi bi-plus"></i></button>
                </div>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <button class="btn btn-brand btn-lg shadow" type="submit" ${product.stock le 0 ? 'disabled' : ''}>
                            <i class="bi bi-cart-plus me-2"></i> Add to cart
                        </button>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-brand btn-lg shadow" href="${pageContext.request.contextPath}/login">
                            <i class="bi bi-box-arrow-in-right me-2"></i> Sign in to purchase
                        </a>
                    </c:otherwise>
                </c:choose>
            </form>

            <c:if test="${not empty sessionScope.user}">
                <form action="${pageContext.request.contextPath}/wishlist" method="post" class="m-0">
                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                    <input type="hidden" name="productId" value="${product.id}">
                    <button class="btn btn-outline-dark btn-lg rounded-circle p-2" type="submit" title="Add to Wishlist" style="width: 48px; height: 48px;">
                        <i class="bi bi-heart"></i>
                    </button>
                </form>
            </c:if>
        </div>

        <!-- Trust Badges -->
        <div class="card border-0 bg-light rounded-4 p-3 mb-2">
            <div class="d-flex flex-wrap gap-4 text-muted small">
                <span><i class="bi bi-truck text-brand me-1 fs-6"></i> Free shipping over ₹500</span>
                <span><i class="bi bi-arrow-counterclockwise text-brand me-1 fs-6"></i> 7-day hassle-free returns</span>
                <span><i class="bi bi-shield-check text-brand me-1 fs-6"></i> 100% Genuine product</span>
            </div>
        </div>
    </div>
</div>

<!-- Reviews Section -->
<section id="reviews" class="review-panel card border-0 rounded-4 p-4 p-lg-5 shadow-sm mt-5 reveal delay-1">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <span class="eyebrow"><i class="bi bi-chat-quote-fill"></i> Customer Feedback</span>
            <h2 class="h3 font-display m-0">Ratings & Reviews</h2>
        </div>
        <div class="d-flex align-items-center gap-3">
            <div class="display-6 font-display fw-bold text-dark"><fmt:formatNumber value="${product.rating}" minFractionDigits="1" maxFractionDigits="1"/></div>
            <div>
                <ss:rating value="${product.rating}"/>
                <div class="text-muted small"><c:out value="${product.reviewCount}"/> reviews overall</div>
            </div>
        </div>
    </div>

    <!-- Review Form for Authenticated Users -->
    <div class="card bg-light border-0 rounded-4 p-4 mb-4">
        <h3 class="h5 font-display mb-3">Write a Customer Review</h3>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <form action="${pageContext.request.contextPath}/reviews" method="post" class="row g-3">
                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                    <input type="hidden" name="productId" value="${product.id}">
                    
                    <div class="col-md-4">
                        <label class="form-label fw-bold small">Your Rating</label>
                        <div class="d-flex align-items-center gap-2">
                            <div class="star-rating-interactive d-flex gap-1 fs-4" title="Click to rate">
                                <i class="bi bi-star" data-value="1"></i>
                                <i class="bi bi-star" data-value="2"></i>
                                <i class="bi bi-star" data-value="3"></i>
                                <i class="bi bi-star" data-value="4"></i>
                                <i class="bi bi-star" data-value="5"></i>
                            </div>
                            <select class="form-select form-select-sm d-none" name="rating">
                                <option value="5" selected>5</option>
                                <option value="4">4</option>
                                <option value="3">3</option>
                                <option value="2">2</option>
                                <option value="1">1</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-md-8">
                        <label class="form-label fw-bold small">Review Headline</label>
                        <input class="form-control" name="title" required maxlength="120" placeholder="e.g. Exceptional sound and comfort!">
                    </div>
                    
                    <div class="col-12">
                        <label class="form-label fw-bold small">Detailed Review</label>
                        <textarea class="form-control" name="body" rows="3" required maxlength="2000" placeholder="What did you like or dislike about this product?"></textarea>
                    </div>
                    
                    <div class="col-12">
                        <button class="btn btn-brand" type="submit">
                            <i class="bi bi-send me-1"></i> Submit Review
                        </button>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <div class="text-center py-3">
                    <p class="text-muted mb-2">Have you tried this product?</p>
                    <a class="btn btn-outline-dark btn-sm rounded-pill px-4" href="${pageContext.request.contextPath}/login">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Sign in to leave a review
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Review List -->
    <div class="review-list">
        <c:choose>
            <c:when test="${empty reviews}">
                <div class="text-center py-4 text-muted">
                    <i class="bi bi-chat-heart display-6 d-block mb-2"></i>
                    No customer reviews yet. Be the first to share your thoughts!
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="review" items="${reviews}">
                    <article class="review-entry p-3 mb-3 bg-white rounded-3 border border-light-subtle shadow-sm">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div class="d-flex align-items-center gap-2">
                                <div class="rounded-circle bg-secondary-subtle d-grid place-items-center fw-bold text-dark" style="width: 36px; height: 36px;">
                                    <c:out value="${fn:substring(review.reviewerName, 0, 1)}"/>
                                </div>
                                <div>
                                    <strong class="d-block text-dark"><c:out value="${review.title}"/></strong>
                                    <small class="text-muted"><c:out value="${review.reviewerName}"/> · <c:out value="${review.createdAt}"/></small>
                                </div>
                            </div>
                            <span class="badge bg-warning-subtle text-warning-emphasis px-2 py-1 rounded-pill">
                                ★ <c:out value="${review.rating}"/> / 5
                            </span>
                        </div>
                        <p class="mb-0 text-secondary ps-5"><c:out value="${review.body}"/></p>
                    </article>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
