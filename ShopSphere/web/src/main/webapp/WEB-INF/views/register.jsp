<%@ include file="/WEB-INF/fragments/header.jsp" %>
<section class="auth-card">
    <span class="eyebrow">Join the community</span><h1>Create your account</h1>
    <form method="post" action="${pageContext.request.contextPath}/register" class="vstack gap-3">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
        <label>Full name<input class="form-control" name="fullName" autocomplete="name" required maxlength="120"></label>
        <label>Email<input class="form-control" type="email" name="email" autocomplete="email" required maxlength="254"></label>
        <label>Password<input class="form-control" type="password" name="password" autocomplete="new-password" minlength="10" maxlength="128" required><small class="form-text">Use at least 10 characters.</small></label>
        <button class="btn btn-brand btn-lg" type="submit">Create account</button>
    </form>
    <p class="mt-3">Already registered? <a href="${pageContext.request.contextPath}/login">Sign in</a></p>
</section>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
