<%@ include file="/WEB-INF/fragments/header.jsp" %>
<section class="auth-card"><span class="eyebrow">Restricted area</span><h1>Administrator sign in</h1>
    <form action="${pageContext.request.contextPath}/admin/login" method="post" class="vstack gap-3">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
        <label>Email<input class="form-control" type="email" name="email" required maxlength="254"></label>
        <label>Password<input class="form-control" type="password" name="password" required></label>
        <button class="btn btn-brand" type="submit">Continue to admin</button>
    </form>
</section>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
