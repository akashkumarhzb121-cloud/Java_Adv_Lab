<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout"><%@ include file="/WEB-INF/fragments/sidebar.jsp" %><section class="admin-content">
    <span class="eyebrow">Stock control</span><h1>Low-stock inventory</h1>
    <p class="text-muted">Active products with five or fewer units are shown here.</p>
    <div class="table-responsive"><table class="table shop-table align-middle"><thead><tr><th>Product</th><th>Category</th><th>Available</th><th>Restock</th></tr></thead><tbody>
        <c:forEach var="product" items="${products}"><tr><td><c:out value="${product.name}"/></td><td><c:out value="${product.categoryName}"/></td><td class="text-danger fw-bold"><c:out value="${product.stock}"/></td><td>
            <form action="${pageContext.request.contextPath}/admin/inventory" method="post" class="d-flex gap-2"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="productId" value="${product.id}"><input class="form-control form-control-sm" type="number" name="quantity" value="10" min="1" max="1000000" aria-label="Restock quantity"><button class="btn btn-outline-dark btn-sm" type="submit">Add stock</button></form>
        </td></tr></c:forEach>
    </tbody></table></div>
</section></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
