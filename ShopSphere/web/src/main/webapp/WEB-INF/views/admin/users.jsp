<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout"><%@ include file="/WEB-INF/fragments/sidebar.jsp" %><section class="admin-content">
    <span class="eyebrow">Customer accounts</span><h1>Customers</h1>
    <div class="table-responsive"><table class="table shop-table"><thead><tr><th>Name</th><th>Email</th><th>Phone</th><th>Account controls</th></tr></thead><tbody>
        <c:forEach var="account" items="${users}"><tr><td><c:out value="${account.user.fullName}"/></td><td><c:out value="${account.user.email}"/></td><td><c:out value="${account.user.phone}"/></td><td>
            <span class="status-badge"><c:out value="${account.active ? 'Active' : 'Inactive'}"/></span>
            <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="userId" value="${account.user.id}"><input type="hidden" name="action" value="${account.active ? 'deactivate' : 'activate'}"><button class="btn btn-outline-dark btn-sm" type="submit">${account.active ? 'Deactivate' : 'Activate'}</button></form>
        </td></tr></c:forEach>
    </tbody></table></div>
</section></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
