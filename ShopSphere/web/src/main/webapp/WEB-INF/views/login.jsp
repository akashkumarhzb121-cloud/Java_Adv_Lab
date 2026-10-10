<%@ include file="/WEB-INF/fragments/header.jsp" %>
<section class="auth-card">
    <span class="eyebrow">Welcome back</span><h1>Sign in to ShopSphere</h1>
    <p class="text-muted">Access your wishlist, orders, and saved shopping experience.</p>
    <form method="post" action="${pageContext.request.contextPath}/login" class="vstack gap-3">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
        <label>Email<input class="form-control" type="email" name="email" autocomplete="email" required maxlength="254"></label>
        <label>Password<input class="form-control" type="password" name="password" autocomplete="current-password" required></label>
        <button class="btn btn-brand btn-lg" type="submit">Sign in</button>
    </form>
    <p class="mt-3 mb-0">New here? <a href="${pageContext.request.contextPath}/register">Create an account</a></p>
</section>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
