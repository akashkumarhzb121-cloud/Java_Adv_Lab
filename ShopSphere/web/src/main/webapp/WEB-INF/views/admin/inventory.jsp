<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout">
    <%@ include file="/WEB-INF/fragments/sidebar.jsp" %>
    <section class="admin-content">
        <span class="eyebrow"><i class="bi bi-exclamation-triangle"></i> Stock Depletion Control</span>
        <h1 class="h2 font-display mb-1">Low-Stock Inventory</h1>
        <p class="text-muted small mb-4">Active products with 5 or fewer items remaining. Add stock to restore inventory.</p>

        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-5">
            <c:choose>
                <c:when test="${empty products}">
                    <div class="text-center py-5">
                        <i class="bi bi-check-circle-fill display-4 text-success d-block mb-3"></i>
                        <h3 class="h5 font-display">All products are adequately stocked</h3>
                        <p class="text-muted small">No active products currently have 5 or fewer units.</p>
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-dark btn-sm rounded-pill px-3">
                            View All Products
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table shop-table align-middle">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Category</th>
                                    <th>Units Remaining</th>
                                    <th>Restock Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td>
                                            <strong><c:out value="${product.name}"/></strong>
                                        </td>
                                        <td><span class="badge bg-light text-dark"><c:out value="${product.categoryName}"/></span></td>
                                        <td>
                                            <span class="badge bg-danger-subtle text-danger fs-6 px-3 py-1 rounded-pill">
                                                <i class="bi bi-exclamation-circle me-1"></i> <c:out value="${product.stock}"/> left
                                            </span>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/inventory" method="post" class="d-flex align-items-center gap-2 m-0">
                                                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                
                                                <div class="input-group input-group-sm" style="max-width: 140px;">
                                                    <span class="input-group-text bg-light">+</span>
                                                    <input class="form-control" type="number" name="quantity" value="25" min="1" max="100000" aria-label="Restock quantity">
                                                </div>
                                                
                                                <button class="btn btn-brand btn-sm rounded-pill px-3" type="submit">
                                                    <i class="bi bi-plus-circle me-1"></i> Add Stock
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
