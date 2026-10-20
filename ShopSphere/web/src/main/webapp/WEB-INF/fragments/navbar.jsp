<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<fmt:setBundle basename="com.shopsphere.messages"/>
<nav class="navbar navbar-expand-lg navbar-dark shop-nav sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2 fw-bold" href="${pageContext.request.contextPath}/home">
            <span class="brand-logo-icon"><i class="bi bi-box2-heart-fill"></i></span>
            <span>Shop<span class="brand-accent">Sphere</span></span>
        </a>

        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNav">
            <!-- Search bar with animated input -->
            <form class="d-flex mx-lg-auto my-3 my-lg-0 search-form position-relative" action="${pageContext.request.contextPath}/products" method="get" role="search">
                <input class="form-control nav-search-input pe-5" type="search" name="q" value="<c:out value='${param.q}'/>" placeholder="Search gadgets, home, fashion..." aria-label="Search products">
                <button class="btn btn-search-icon" type="submit" aria-label="Search">
                    <i class="bi bi-search"></i>
                </button>
            </form>

            <ul class="navbar-nav align-items-lg-center gap-lg-2">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/home' ? 'active' : ''}" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door me-1"></i> <fmt:message key="nav.home"/>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/products' ? 'active' : ''}" href="${pageContext.request.contextPath}/products">
                        <i class="bi bi-grid me-1"></i> <fmt:message key="nav.shop"/>
                    </a>
                </li>

                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link position-relative ${pageContext.request.servletPath == '/wishlist' ? 'active' : ''}" href="${pageContext.request.contextPath}/wishlist">
                            <i class="bi bi-heart me-1"></i> <fmt:message key="nav.wishlist"/>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link position-relative d-inline-flex align-items-center ${pageContext.request.servletPath == '/cart' ? 'active' : ''}" href="${pageContext.request.contextPath}/cart">
                            <i class="bi bi-cart3 me-1 fs-5"></i>
                            <span class="d-none d-lg-inline"><fmt:message key="nav.cart"/></span>
                            <span class="cart-count-badge pulse-badge"><c:out value="${requestScope.cartCount != null ? requestScope.cartCount : '0'}"/></span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.servletPath == '/orders' ? 'active' : ''}" href="${pageContext.request.contextPath}/orders">
                            <i class="bi bi-box-seam me-1"></i> <fmt:message key="nav.orders"/>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-inline-flex align-items-center gap-1" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle fs-5"></i>
                            <span><c:out value="${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'Account'}"/></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-4 p-2 custom-dropdown">
                            <li><a class="dropdown-item rounded-3" href="${pageContext.request.contextPath}/account/profile"><i class="bi bi-person me-2"></i> Profile &amp; Addresses</a></li>
                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                <li><a class="dropdown-item rounded-3 text-primary fw-semibold" href="${pageContext.request.contextPath}/admin"><i class="bi bi-speedometer2 me-2"></i> Admin Dashboard</a></li>
                            </c:if>
                            <li><hr class="dropdown-divider my-1"></li>
                            <li>
                                <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0 p-0">
                                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                    <button class="dropdown-item rounded-3 text-danger" type="submit">
                                        <i class="bi bi-box-arrow-right me-2"></i> <fmt:message key="nav.signOut"/>
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </c:if>

                <c:if test="${empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link position-relative d-inline-flex align-items-center ${pageContext.request.servletPath == '/cart' ? 'active' : ''}" href="${pageContext.request.contextPath}/cart">
                            <i class="bi bi-cart3 me-1 fs-5"></i>
                            <span><fmt:message key="nav.cart"/></span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.servletPath == '/login' ? 'active' : ''}" href="${pageContext.request.contextPath}/login">
                            <i class="bi bi-box-arrow-in-right me-1"></i> <fmt:message key="nav.signIn"/>
                        </a>
                    </li>
                    <li class="nav-item ms-lg-1">
                        <a class="btn btn-brand btn-sm shadow-sm" href="${pageContext.request.contextPath}/register">
                            <i class="bi bi-person-plus me-1"></i> Register
                        </a>
                    </li>
                </c:if>
            </ul>

            <!-- Language Switcher: Only English and Hindi as requested -->
            <form action="${pageContext.request.contextPath}/locale" method="post" class="ms-lg-3 my-2 my-lg-0">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                <div class="lang-selector-wrap">
                    <i class="bi bi-globe2 lang-icon"></i>
                    <select class="form-select form-select-sm lang-select" name="language" aria-label="Language" onchange="this.form.submit()">
                        <option value="en" ${sessionScope.locale == 'en' ? 'selected' : ''}>English</option>
                        <option value="hi" ${sessionScope.locale == 'hi' ? 'selected' : ''}>&#2361;&#2367;&#2344;&#2381;&#2342;&#2368;</option>
                    </select>
                </div>
            </form>
        </div>
    </div>
</nav>
