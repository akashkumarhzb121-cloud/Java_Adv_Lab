<%@ include file="/WEB-INF/fragments/header.jsp" %>
<%@ taglib prefix="ss" tagdir="/WEB-INF/tags" %>
<section class="hero-banner">
    <div><span class="eyebrow">The ShopSphere edit</span><h1>Good things, <span>well chosen.</span></h1>
        <p>Everyday essentials and thoughtful finds, all in one place.</p>
        <a class="btn btn-light btn-lg" href="#catalog">Explore the collection</a></div>
    <div class="hero-orb" aria-hidden="true">S</div>
</section>
<section id="catalog" class="mt-5">
    <div class="section-heading"><div><span class="eyebrow">Curated for you</span><h2>Shop the collection</h2></div>
        <form method="get" action="${pageContext.request.contextPath}/products" class="filter-row">
            <input class="form-control" type="search" name="q" value="<c:out value='${param.q}'/>" placeholder="Search">
            <select class="form-select" name="category"><option value="">All categories</option>
                <c:forEach var="category" items="${categories}"><option value="${category.id}" ${param.category == category.id ? 'selected' : ''}><c:out value="${category.name}"/></option></c:forEach>
            </select>
            <select class="form-select" name="sort">
                <option value="">Newest</option><option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Price: low to high</option>
                <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Price: high to low</option><option value="name" ${param.sort == 'name' ? 'selected' : ''}>Name</option>
            </select><button class="btn btn-outline-dark" type="submit">Apply</button>
        </form>
    </div>
    <c:choose><c:when test="${empty products}"><div class="empty-state"><h3>No products found</h3><p>Try a different search or category.</p></div></c:when>
        <c:otherwise><div class="product-grid"><c:forEach var="product" items="${products}"><ss:productCard product="${product}"/></c:forEach></div></c:otherwise>
    </c:choose>
</section>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
