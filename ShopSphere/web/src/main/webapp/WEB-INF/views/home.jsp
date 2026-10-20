<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/fragments/header.jsp" %>
<%@ taglib prefix="ss" tagdir="/WEB-INF/tags" %>

<!-- Animated Hero Banner -->
<section class="hero-banner reveal mb-5">
    <div class="hero-content">
        <span class="eyebrow"><i class="bi bi-stars"></i> ShopSphere 2026 Collection</span>
        <h1>Objects that feel <span class="brand-accent">quietly special.</span></h1>
        <p>A modern full-stack Java e-commerce store with smooth browsing, secure checkout, and a complete Advanced Java lab behind the scenes.</p>
        <div class="d-flex flex-wrap gap-3 align-items-center">
            <a class="btn btn-dark btn-lg rounded-pill shadow-sm px-4" href="${pageContext.request.contextPath}/products">
                <i class="bi bi-bag me-1"></i> Explore the shop
            </a>
            <a class="btn btn-outline-dark btn-lg rounded-pill px-4" href="#featured">
                <i class="bi bi-arrow-down-short"></i> See featured
            </a>
        </div>
    </div>
    <div class="hero-orb-wrap" aria-hidden="true">
        <div class="hero-orb">S</div>
        <div class="hero-orb small">✦</div>
        <div class="floating-chip">
            <i class="bi bi-shield-check text-success fs-6"></i> Verified Quality
        </div>
    </div>
</section>

<!-- Promotional Coupon Banner -->
<section class="reveal delay-1 mb-5">
    <div class="card border-0 rounded-4 p-4 shadow-sm" style="background: linear-gradient(135deg, #091e1b, #12332e); color: #fff;">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
            <div>
                <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold mb-2">
                    <i class="bi bi-gift-fill me-1"></i> Welcome Offer
                </span>
                <h3 class="text-white h4 m-0 font-display">Enjoy 10% OFF on your first purchase</h3>
                <p class="text-secondary small mb-0 mt-1">Use voucher code at checkout on orders above &#8377;500.</p>
            </div>
            <div class="d-flex align-items-center gap-2">
                <span class="fs-5 font-monospace fw-bold px-3 py-2 rounded-3 border border-secondary border-opacity-50" style="background: rgba(255,255,255,0.08);">WELCOME10</span>
                <button type="button" class="btn btn-brand btn-copy-coupon" data-code="WELCOME10">
                    <i class="bi bi-clipboard me-1"></i> Copy Code
                </button>
            </div>
        </div>
    </div>
</section>

<!-- Shop by Category -->
<section class="reveal delay-1 mb-5">
    <div class="section-heading">
        <div>
            <span class="eyebrow"><i class="bi bi-grid-fill"></i> Departments</span>
            <h2>Shop by category</h2>
        </div>
        <a href="${pageContext.request.contextPath}/products" class="text-muted small fw-semibold">View all <i class="bi bi-arrow-right"></i></a>
    </div>
    <div class="category-grid">
        <c:forEach var="category" items="${categories}">
            <a class="category-tile" href="${pageContext.request.contextPath}/products?category=${category.id}">
                <div>
                    <span class="eyebrow">Department</span>
                    <strong><c:out value="${category.name}"/></strong>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <span class="text-muted small">Explore products</span>
                    <i class="bi bi-arrow-right text-brand"></i>
                </div>
                <i class="bi bi-box-seam category-icon-bg"></i>
            </a>
        </c:forEach>
    </div>
</section>

<!-- Featured Products -->
<section id="featured" class="reveal delay-2 mb-5">
    <div class="section-heading">
        <div>
            <span class="eyebrow"><i class="bi bi-fire"></i> Editor's picks</span>
            <h2>Featured this week</h2>
        </div>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark btn-sm rounded-pill px-3">
            Browse all products →
        </a>
    </div>
    <div class="product-grid">
        <c:forEach var="product" items="${featured}">
            <ss:productCard product="${product}"/>
        </c:forEach>
    </div>
</section>

<!-- Recently Viewed (from Cookies) -->
<c:if test="${not empty recent}">
    <section class="reveal delay-3 mb-5">
        <div class="section-heading">
            <div>
                <span class="eyebrow"><i class="bi bi-clock-history"></i> Picked up from a cookie</span>
                <h2>Recently viewed</h2>
            </div>
        </div>
        <div class="product-grid">
            <c:forEach var="product" items="${recent}">
                <ss:productCard product="${product}"/>
            </c:forEach>
        </div>
    </section>
</c:if>

<!-- Value Props / Why ShopSphere -->
<section class="reveal delay-3 mb-5">
    <div class="section-heading">
        <div>
            <span class="eyebrow"><i class="bi bi-patch-check"></i> Enterprise Java Standards</span>
            <h2>Designed for seamless commerce</h2>
        </div>
    </div>
    <div class="perk-grid">
        <article class="perk-card">
            <div class="d-inline-flex p-3 rounded-4 bg-light text-brand mb-3">
                <i class="bi bi-shield-lock-fill fs-3 text-brand"></i>
            </div>
            <h3>Hashed Passwords</h3>
            <p class="mb-0 text-muted">Accounts employ salted PBKDF2 cryptography, authenticated HttpSession management, and CSRF tokens across all forms.</p>
        </article>
        <article class="perk-card">
            <div class="d-inline-flex p-3 rounded-4 bg-light text-brand mb-3">
                <i class="bi bi-receipt fs-3 text-brand"></i>
            </div>
            <h3>Server-Side Totals</h3>
            <p class="mb-0 text-muted">Cart subtotals, coupon percentage math, discounts, and inventory decrements execute exclusively in transactional JDBC.</p>
        </article>
        <article class="perk-card">
            <div class="d-inline-flex p-3 rounded-4 bg-light text-brand mb-3">
                <i class="bi bi-diagram-3-fill fs-3 text-brand"></i>
            </div>
            <h3>N-Tier Architecture</h3>
            <p class="mb-0 text-muted">A layered stack from JSP/EL to Servlets, Services, DAOs and MySQL — complemented by standalone Swing, Sockets and RMI.</p>
        </article>
    </div>
</section>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
