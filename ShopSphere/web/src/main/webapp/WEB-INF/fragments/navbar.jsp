<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<nav class="navbar navbar-expand-lg navbar-dark shop-nav">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/products">Shop<span>Sphere</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav"
                aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="mainNav">
            <form class="d-flex mx-lg-auto my-3 my-lg-0 search-form" action="${pageContext.request.contextPath}/products" method="get">
                <input class="form-control" type="search" name="q" value="<c:out value='${param.q}'/>" placeholder="Search products" aria-label="Search products">
                <button class="btn btn-brand" type="submit">Search</button>
            </form>
            <ul class="navbar-nav align-items-lg-center gap-lg-2">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products"><fmt:message key="nav.shop"/></a></li>
                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/wishlist"><fmt:message key="nav.wishlist"/></a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cart"><fmt:message key="nav.cart"/> <span class="cart-count"><c:out value="${requestScope.cartCount}"/></span></a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/orders"><fmt:message key="nav.orders"/></a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/account/profile">Profile</a></li>
                    <c:if test="${sessionScope.user.admin}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin">Admin</a></li>
                    </c:if>
                    <li class="nav-item">
                        <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
                            <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                            <button class="btn btn-link nav-link" type="submit"><fmt:message key="nav.signOut"/></button>
                        </form>
                    </li>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login"><fmt:message key="nav.signIn"/></a></li>
                    <li class="nav-item"><a class="btn btn-brand btn-sm" href="${pageContext.request.contextPath}/register">Create account</a></li>
                </c:if>
            </ul>
            <form action="${pageContext.request.contextPath}/locale" method="post" class="ms-lg-3">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                <select class="form-select form-select-sm" name="language" aria-label="Language" onchange="this.form.submit()">
                    <option value="en" ${sessionScope.locale == 'en' ? 'selected' : ''}>English</option>
                    <option value="hi" ${sessionScope.locale == 'hi' ? 'selected' : ''}>हिन्दी</option>
                </select>
            </form>
        </div>
    </div>
</nav>
