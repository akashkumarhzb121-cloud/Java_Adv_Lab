<%@ include file="/WEB-INF/fragments/header.jsp" %>
<%@ taglib prefix="ss" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!-- Mini Banner -->
<section class="hero-banner reveal mb-4" style="min-height: 280px; padding: 2.5rem clamp(1.5rem, 4vw, 3.5rem);">
    <div>
        <span class="eyebrow"><i class="bi bi-compass"></i> The ShopSphere Edit</span>
        <h1 class="h2">Curated goods, <span class="brand-accent">crafted to last.</span></h1>
        <p class="mb-0 text-muted">Filter by department, sort by price, or search for your favorite objects.</p>
    </div>
    <div class="hero-orb-wrap d-none d-md-flex" aria-hidden="true">
        <div class="hero-orb" style="width: 140px; height: 140px; font-size: 4rem;">S</div>
    </div>
</section>

<!-- Filter & Search Controls -->
<section id="catalog" class="reveal delay-1 mb-5">
    <!-- Category Quick Filter Pills -->
    <div class="d-flex flex-wrap gap-2 mb-3">
        <a href="${pageContext.request.contextPath}/products"
           class="btn btn-sm rounded-pill ${empty param.category ? 'btn-dark' : 'btn-outline-secondary'}">
            All Products
        </a>
        <c:forEach var="cat" items="${categories}">
            <a href="${pageContext.request.contextPath}/products?category=${cat.id}"
               class="btn btn-sm rounded-pill ${param.category == cat.id ? 'btn-dark' : 'btn-outline-secondary'}">
                <c:out value="${cat.name}"/>
            </a>
        </c:forEach>
    </div>

    <div class="section-heading mt-0 pt-0">
        <div>
            <h2>Collection Catalog</h2>
            <p class="text-muted mb-0"><c:out value="${fn:length(products)}"/> products found</p>
        </div>
        <form method="get" action="${pageContext.request.contextPath}/products" class="filter-row d-flex gap-2 flex-wrap">
            <div class="input-group">
                <input class="form-control" type="search" name="q" value="<c:out value='${param.q}'/>" placeholder="Search by name...">
                <c:if test="${not empty param.category}">
                    <input type="hidden" name="category" value="<c:out value='${param.category}'/>">
                </c:if>
            </div>
            <select class="form-select" name="sort" onchange="this.form.submit()" style="min-width: 160px;">
                <option value="">Sort: Newest</option>
                <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Price: Low to High</option>
                <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Price: High to Low</option>
                <option value="name" ${param.sort == 'name' ? 'selected' : ''}>Product Name</option>
            </select>
            <button class="btn btn-dark rounded-pill px-3" type="submit">Filter</button>
            <c:if test="${not empty param.q || not empty param.category || not empty param.sort}">
                <a class="btn btn-outline-danger rounded-pill px-3" href="${pageContext.request.contextPath}/products" title="Clear Filters">
                    <i class="bi bi-x-lg"></i>
                </a>
            </c:if>
        </form>
    </div>

    <c:choose>
        <c:when test="${empty products}">
            <div class="empty-state card border-0 p-5 shadow-sm text-center my-4">
                <div class="display-3 text-muted mb-3"><i class="bi bi-search"></i></div>
                <h3 class="font-display">No products found</h3>
                <p class="text-muted mb-4">We could not find items matching your criteria. Try resetting your search or filter.</p>
                <div>
                    <a class="btn btn-brand" href="${pageContext.request.contextPath}/products">View all products</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach var="product" items="${products}">
                    <ss:productCard product="${product}"/>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</section>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
