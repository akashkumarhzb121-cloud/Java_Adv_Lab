<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout"><%@ include file="/WEB-INF/fragments/sidebar.jsp" %><section class="admin-content">
    <span class="eyebrow">Catalog organization</span><h1>Categories</h1>
    <form action="${pageContext.request.contextPath}/admin/categories" method="post" class="summary-card row g-3 mb-4">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="add">
        <div class="col-md-5"><label>Name<input class="form-control" name="name" required maxlength="100"></label></div>
        <div class="col-md-7"><label>Description<input class="form-control" name="description" maxlength="500"></label></div>
        <div class="col-12"><button class="btn btn-brand" type="submit">Add category</button></div>
    </form>
    <div class="table-responsive"><table class="table shop-table"><thead><tr><th>Name</th><th>Slug</th><th>Status</th><th></th></tr></thead><tbody><c:forEach var="category" items="${categories}"><tr><td><c:out value="${category.name}"/></td><td><c:out value="${category.slug}"/></td><td><c:out value="${category.active ? 'Active' : 'Hidden'}"/></td><td><form action="${pageContext.request.contextPath}/admin/categories" method="post"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="setActive"><input type="hidden" name="id" value="${category.id}"><input type="hidden" name="active" value="${category.active ? 'false' : 'true'}"><button class="btn btn-outline-dark btn-sm" type="submit">${category.active ? 'Hide' : 'Activate'}</button></form></td></tr></c:forEach></tbody></table></div>
</section></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
