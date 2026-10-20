<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout">
    <%@ include file="/WEB-INF/fragments/sidebar.jsp" %>
    <section class="admin-content">
        <span class="eyebrow"><i class="bi bi-box-seam"></i> Catalog Management</span>
        <h1 class="h2 font-display mb-1">Products & Inventory</h1>
        <p class="text-muted small mb-4">Create, edit, or adjust catalog products and their stock availability.</p>

        <!-- Product Form Card -->
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-4">
            <h2 class="h5 font-display mb-3"><i class="bi bi-pencil-square me-2 text-brand"></i>Add or Update Product</h2>
            <form action="${pageContext.request.contextPath}/admin/products" method="post" class="row g-3">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                
                <div class="col-md-2">
                    <label class="form-label small fw-bold">ID (blank to new)</label>
                    <input class="form-control" name="id" type="number" min="1" placeholder="Auto">
                </div>
                <div class="col-md-5">
                    <label class="form-label small fw-bold">Product Name</label>
                    <input class="form-control" name="name" required maxlength="180" placeholder="e.g. Mechanical Keyboard">
                </div>
                <div class="col-md-5">
                    <label class="form-label small fw-bold">URL Slug</label>
                    <input class="form-control" name="slug" required maxlength="200" placeholder="e.g. mechanical-keyboard">
                </div>
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Category</label>
                    <select class="form-select" name="categoryId" required>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}"><c:out value="${category.name}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold">Price (₹)</label>
                    <input class="form-control" name="price" type="number" step="0.01" min="0" required placeholder="1999.00">
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-bold">Discount %</label>
                    <input class="form-control" name="discountPercent" type="number" step="0.01" min="0" max="100" value="0" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold">Initial Stock</label>
                    <input class="form-control" name="stock" type="number" min="0" required placeholder="50">
                </div>
                <div class="col-12">
                    <label class="form-label small fw-bold">Description</label>
                    <textarea class="form-control" name="description" required rows="2" placeholder="Brief description of product features and dimensions..."></textarea>
                </div>
                <div class="col-md-9">
                    <label class="form-label small fw-bold">Image URL</label>
                    <input class="form-control" name="imageUrl" type="url" maxlength="1000" placeholder="https://images.unsplash.com/...">
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold">Catalog Visibility</label>
                    <select class="form-select" name="active">
                        <option value="true">Active (Visible)</option>
                        <option value="false">Hidden (Inactive)</option>
                    </select>
                </div>
                <div class="col-12 mt-3">
                    <button class="btn btn-brand" type="submit">
                        <i class="bi bi-save me-1"></i> Save Product
                    </button>
                </div>
            </form>
        </div>

        <!-- Products Table -->
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-5">
            <h2 class="h5 font-display mb-3">All Listed Products (<c:out value="${fn:length(products)}"/>)</h2>
            <div class="table-responsive">
                <table class="table shop-table align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>#<c:out value="${product.id}"/></td>
                                <td>
                                    <strong><c:out value="${product.name}"/></strong>
                                </td>
                                <td><span class="badge bg-light text-dark"><c:out value="${product.categoryName}"/></span></td>
                                <td>₹<fmt:formatNumber value="${product.price}" minFractionDigits="2"/></td>
                                <td>
                                    <span class="badge ${product.stock le 5 ? 'bg-danger-subtle text-danger' : 'bg-success-subtle text-success'}">
                                        <c:out value="${product.stock}"/> units
                                    </span>
                                </td>
                                <td>
                                    <span class="badge ${product.active ? 'bg-success-subtle text-success' : 'bg-secondary-subtle text-secondary'}">
                                        <c:out value="${product.active ? 'Active' : 'Hidden'}"/>
                                    </span>
                                </td>
                                <td class="text-end">
                                    <form action="${pageContext.request.contextPath}/admin/products" method="post" class="d-inline">
                                        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                        <input type="hidden" name="action" value="setActive">
                                        <input type="hidden" name="id" value="${product.id}">
                                        <input type="hidden" name="active" value="${product.active ? 'false' : 'true'}">
                                        <button class="btn btn-outline-dark btn-sm rounded-pill" type="submit">
                                            <c:out value="${product.active ? 'Hide' : 'Activate'}"/>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
