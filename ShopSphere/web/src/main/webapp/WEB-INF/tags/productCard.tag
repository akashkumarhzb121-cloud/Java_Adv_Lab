<%@ tag body-content="empty" %>
<%@ attribute name="product" required="true" type="com.shopsphere.model.Product" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<article class="product-card h-100">
    <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="product-image-wrap">
        <img class="product-image" src="<c:out value='${product.imageUrl}'/>" alt="<c:out value='${product.name}'/>"
             loading="lazy" onerror="this.src='${pageContext.request.contextPath}/assets/images/product-placeholder.svg'">
        <c:if test="${product.discountPercent gt 0}"><span class="discount-pill">-<fmt:formatNumber value="${product.discountPercent}" maxFractionDigits="0"/>%</span></c:if>
    </a>
    <div class="product-info">
        <small class="text-muted"><c:out value="${product.categoryName}"/></small>
        <h3><a href="${pageContext.request.contextPath}/product?id=${product.id}"><c:out value="${product.name}"/></a></h3>
        <p class="rating">★ <fmt:formatNumber value="${product.rating}" maxFractionDigits="1"/> <small>(<c:out value="${product.reviewCount}"/>)</small></p>
        <div class="d-flex align-items-center gap-2">
            <strong class="price">₹<fmt:formatNumber value="${product.salePrice}" minFractionDigits="2"/></strong>
            <c:if test="${product.discountPercent gt 0}"><del class="text-muted small">₹<fmt:formatNumber value="${product.price}"/></del></c:if>
        </div>
        <c:choose>
            <c:when test="${product.stock gt 0}"><small class="stock-ok">In stock</small></c:when>
            <c:otherwise><small class="text-danger">Out of stock</small></c:otherwise>
        </c:choose>
    </div>
</article>
