<%@ tag body-content="empty" pageEncoding="UTF-8" %>
<%@ attribute name="product" required="true" type="com.shopsphere.model.Product" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="ss" tagdir="/WEB-INF/tags" %>
<article class="product-card h-100 d-flex flex-column position-relative">
    <div class="product-image-wrap position-relative overflow-hidden">
        <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="d-block w-100 h-100">
            <img class="product-image w-100 h-100" src="<c:out value='${product.imageUrl}'/>" alt="<c:out value='${product.name}'/>"
                 loading="lazy" onerror="this.src='${pageContext.request.contextPath}/assets/images/product-placeholder.svg'">
        </a>
        <c:if test="${product.discountPercent gt 0}">
            <span class="discount-pill">
                <i class="bi bi-tag-fill me-1"></i>-<fmt:formatNumber value="${product.discountPercent}" maxFractionDigits="0"/>%
            </span>
        </c:if>
        <c:if test="${not empty sessionScope.user}">
            <form action="${pageContext.request.contextPath}/wishlist" method="post" class="wishlist-float-form">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                <input type="hidden" name="productId" value="${product.id}">
                <button type="submit" class="btn-wishlist-float" title="Add to Wishlist" aria-label="Add to Wishlist">
                    <i class="bi bi-heart"></i>
                </button>
            </form>
        </c:if>
        <div class="quick-add-wrap">
            <c:choose>
                <c:when test="${product.stock le 0}">
                    <button class="btn btn-secondary w-100 btn-sm disabled" disabled>
                        <i class="bi bi-x-circle me-1"></i> Out of stock
                    </button>
                </c:when>
                <c:when test="${not empty sessionScope.user}">
                    <form class="quick-add w-100 m-0" action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${product.id}">
                        <input type="hidden" name="quantity" value="1">
                        <button class="btn btn-brand w-100 btn-sm shadow-sm" type="submit">
                            <i class="bi bi-cart-plus me-1"></i> Add to cart
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a class="btn btn-brand w-100 btn-sm shadow-sm" href="${pageContext.request.contextPath}/login">
                        <i class="bi bi-cart-plus me-1"></i> Add to cart
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="product-info p-3 d-flex flex-column flex-grow-1 justify-content-between">
        <div>
            <div class="d-flex justify-content-between align-items-center mb-1">
                <span class="product-category-badge"><c:out value="${product.categoryName}"/></span>
                <c:choose>
                    <c:when test="${product.stock gt 0}">
                        <span class="stock-indicator in-stock"><span class="pulse-dot"></span> In stock</span>
                    </c:when>
                    <c:otherwise>
                        <span class="stock-indicator out-of-stock"><span class="pulse-dot red"></span> Sold out</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <h3 class="product-title mb-2">
                <a href="${pageContext.request.contextPath}/product?id=${product.id}"><c:out value="${product.name}"/></a>
            </h3>
            <div class="mb-2">
                <ss:rating value="${product.rating}" count="${product.reviewCount}"/>
            </div>
        </div>
        <div class="pt-2 border-top border-light-subtle d-flex justify-content-between align-items-baseline">
            <div class="price-box">
                <strong class="price fs-5 text-dark">&#8377;<fmt:formatNumber value="${product.salePrice}" minFractionDigits="2"/></strong>
                <c:if test="${product.discountPercent gt 0}">
                    <del class="text-muted small ms-1">&#8377;<fmt:formatNumber value="${product.price}"/></del>
                </c:if>
            </div>
            <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="view-link text-muted small">
                Details <i class="bi bi-arrow-right"></i>
            </a>
        </div>
    </div>
</article>
