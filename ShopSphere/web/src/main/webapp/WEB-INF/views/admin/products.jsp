<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout"><%@ include file="/WEB-INF/fragments/sidebar.jsp" %><section class="admin-content">
    <span class="eyebrow">Catalog</span><h1>Products & inventory</h1>
    <div class="summary-card mb-4"><h2>Add or update a product</h2><form action="${pageContext.request.contextPath}/admin/products" method="post" class="row g-3">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
        <div class="col-md-2"><label>ID (blank to create)<input class="form-control" name="id" type="number" min="1"></label></div>
        <div class="col-md-5"><label>Name<input class="form-control" name="name" required maxlength="180"></label></div>
        <div class="col-md-5"><label>Slug<input class="form-control" name="slug" required maxlength="200"></label></div>
        <div class="col-md-4"><label>Category<select class="form-select" name="categoryId" required><c:forEach var="category" items="${categories}"><option value="${category.id}"><c:out value="${category.name}"/></option></c:forEach></select></label></div>
        <div class="col-md-3"><label>Price (₹)<input class="form-control" name="price" type="number" step="0.01" min="0" required></label></div>
        <div class="col-md-2"><label>Discount %<input class="form-control" name="discountPercent" type="number" step="0.01" min="0" max="100" value="0" required></label></div>
        <div class="col-md-3"><label>Stock<input class="form-control" name="stock" type="number" min="0" required></label></div>
        <div class="col-12"><label>Description<textarea class="form-control" name="description" required rows="2"></textarea></label></div>
        <div class="col-md-9"><label>Image URL<input class="form-control" name="imageUrl" type="url" maxlength="1000"></label></div>
        <div class="col-md-3"><label>Visibility<select class="form-select" name="active"><option value="true">Active</option><option value="false">Hidden</option></select></label></div>
        <div class="col-12"><button class="btn btn-brand" type="submit">Save product</button></div>
    </form></div>
    <div class="table-responsive"><table class="table shop-table"><thead><tr><th>ID</th><th>Product</th><th>Category</th><th>Price</th><th>Stock</th><th>Visibility</th><th></th></tr></thead><tbody>
        <c:forEach var="product" items="${products}"><tr><td><c:out value="${product.id}"/></td><td><c:out value="${product.name}"/></td><td><c:out value="${product.categoryName}"/></td><td>₹<fmt:formatNumber value="${product.price}"/></td><td><span class="${product.stock le 5 ? 'text-danger fw-bold' : ''}"><c:out value="${product.stock}"/></span></td><td><c:out value="${product.active ? 'Active' : 'Hidden'}"/></td>
            <td><form action="${pageContext.request.contextPath}/admin/products" method="post"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="setActive"><input type="hidden" name="id" value="${product.id}"><input type="hidden" name="active" value="${product.active ? 'false' : 'true'}"><button class="btn btn-outline-dark btn-sm" type="submit">${product.active ? 'Hide' : 'Activate'}</button></form></td></tr></c:forEach>
    </tbody></table></div>
</section></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
