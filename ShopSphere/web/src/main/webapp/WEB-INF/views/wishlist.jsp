<%@ include file="/WEB-INF/fragments/header.jsp" %>
<%@ taglib prefix="ss" tagdir="/WEB-INF/tags" %>
<div class="section-heading"><div><span class="eyebrow">Saved for later</span><h1>Your wishlist</h1></div></div>
<c:choose><c:when test="${empty products}"><div class="empty-state"><h2>Your wishlist is waiting</h2><p>Save products to keep your favorites close.</p><a class="btn btn-brand" href="${pageContext.request.contextPath}/products">Browse products</a></div></c:when>
<c:otherwise><div class="product-grid">
    <c:forEach var="product" items="${products}"><div><ss:productCard product="${product}"/>
        <form action="${pageContext.request.contextPath}/wishlist" method="post" class="mt-2"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="productId" value="${product.id}"><button class="btn btn-outline-dark w-100" type="submit">Remove from wishlist</button></form>
    </div></c:forEach></div></c:otherwise></c:choose>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
