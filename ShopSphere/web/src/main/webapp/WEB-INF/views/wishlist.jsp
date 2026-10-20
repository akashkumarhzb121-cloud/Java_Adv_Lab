<%@ include file="/WEB-INF/fragments/header.jsp" %>
<%@ taglib prefix="ss" tagdir="/WEB-INF/tags" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-heart-fill text-danger"></i> Saved Items</span>
        <h1>My Wishlist</h1>
    </div>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-grid me-1"></i> Browse Catalog
    </a>
</div>

<c:choose>
    <c:when test="${empty products}">
        <div class="empty-state card border-0 rounded-4 p-5 shadow-sm text-center my-4">
            <div class="display-3 text-muted mb-3"><i class="bi bi-heart"></i></div>
            <h2 class="font-display">Your wishlist is waiting for favorites</h2>
            <p class="text-muted mb-4">Click the heart icon on any product to save it for later consideration.</p>
            <div>
                <a class="btn btn-brand btn-lg" href="${pageContext.request.contextPath}/products">
                    <i class="bi bi-bag-heart me-2"></i> Explore Products
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="product-grid mb-5">
            <c:forEach var="product" items="${products}">
                <div class="d-flex flex-column h-100">
                    <ss:productCard product="${product}"/>
                    <form action="${pageContext.request.contextPath}/wishlist" method="post" class="mt-2">
                        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button class="btn btn-outline-danger btn-sm w-100 rounded-pill" type="submit">
                            <i class="bi bi-trash3 me-1"></i> Remove from Wishlist
                        </button>
                    </form>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
