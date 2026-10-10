<%@ include file="/WEB-INF/fragments/header.jsp" %>
<nav aria-label="breadcrumb" class="small text-muted mb-4"><a href="${pageContext.request.contextPath}/products">Shop</a> / <c:out value="${product.categoryName}"/></nav>
<div class="row g-5 product-detail">
    <div class="col-lg-6"><img class="detail-image" src="<c:out value='${product.imageUrl}'/>" alt="<c:out value='${product.name}'/>"></div>
    <div class="col-lg-6"><span class="eyebrow"><c:out value="${product.categoryName}"/></span><h1><c:out value="${product.name}"/></h1>
        <p class="rating">★ <fmt:formatNumber value="${product.rating}" maxFractionDigits="1"/> <small>(<c:out value="${product.reviewCount}"/> reviews)</small></p>
        <p class="detail-price">₹<fmt:formatNumber value="${product.salePrice}" minFractionDigits="2"/>
            <c:if test="${product.discountPercent gt 0}"><del>₹<fmt:formatNumber value="${product.price}"/></del></c:if></p>
        <p class="detail-description"><c:out value="${product.description}"/></p>
        <p><c:choose><c:when test="${product.stock gt 0}"><span class="stock-ok">In stock · <c:out value="${product.stock}"/> available</span></c:when><c:otherwise><span class="text-danger">Out of stock</span></c:otherwise></c:choose></p>
        <div class="d-flex gap-2 my-4">
            <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex gap-2">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="${product.id}">
                <input class="form-control quantity-input" type="number" name="quantity" min="1" max="99" value="1" aria-label="Quantity">
                <button class="btn btn-brand btn-lg" type="submit" ${product.stock le 0 ? 'disabled' : ''}>Add to cart</button>
            </form>
            <form action="${pageContext.request.contextPath}/wishlist" method="post">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="productId" value="${product.id}">
                <button class="btn btn-outline-dark btn-lg" type="submit" aria-label="Toggle wishlist">♡</button>
            </form>
        </div>
        <div class="detail-perks"><span>✓ Secure checkout</span><span>✓ Easy order tracking</span><span>✓ Helpful support</span></div>
    </div>
</div>
<section id="reviews" class="review-panel mt-5"><span class="eyebrow">Your experience matters</span><h2>Write a review</h2>
    <c:choose><c:when test="${empty reviews}"><p class="text-muted">No reviews yet. Be the first to share your experience after purchase.</p></c:when>
        <c:otherwise><div class="review-list"><c:forEach var="review" items="${reviews}"><article class="review-entry">
            <div class="d-flex justify-content-between gap-2"><strong><c:out value="${review.title}"/></strong><span class="rating"><c:out value="${review.rating}"/> / 5 ★</span></div>
            <small class="text-muted">By <c:out value="${review.reviewerName}"/> · <c:out value="${review.createdAt}"/></small>
            <p class="mb-0 mt-2"><c:out value="${review.body}"/></p>
        </article></c:forEach></div></c:otherwise></c:choose>
    <c:choose><c:when test="${not empty sessionScope.user}">
        <form action="${pageContext.request.contextPath}/reviews" method="post" class="row g-3">
            <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="productId" value="${product.id}">
            <div class="col-md-3"><label>Rating<select class="form-select" name="rating"><option value="5">5 - Excellent</option><option value="4">4 - Great</option><option value="3">3 - Good</option><option value="2">2 - Fair</option><option value="1">1 - Poor</option></select></label></div>
            <div class="col-md-9"><label>Title<input class="form-control" name="title" maxlength="120"></label></div>
            <div class="col-12"><label>Review<textarea class="form-control" name="body" rows="3" maxlength="2000"></textarea></label></div>
            <div class="col-12"><button class="btn btn-outline-dark" type="submit">Publish review</button></div>
        </form>
    </c:when><c:otherwise><p><a href="${pageContext.request.contextPath}/login">Sign in</a> to leave a review.</p></c:otherwise></c:choose>
</section>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
