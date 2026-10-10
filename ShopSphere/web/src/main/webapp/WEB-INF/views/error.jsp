<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="empty-state"><span class="eyebrow">Something went wrong</span><h1>We couldn't complete that request</h1>
    <p><c:out value="${error}"/></p><a class="btn btn-brand" href="${pageContext.request.contextPath}/products">Back to shop</a></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
