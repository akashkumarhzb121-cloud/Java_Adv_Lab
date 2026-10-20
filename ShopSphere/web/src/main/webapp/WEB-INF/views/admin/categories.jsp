<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout">
    <%@ include file="/WEB-INF/fragments/sidebar.jsp" %>
    <section class="admin-content">
        <span class="eyebrow"><i class="bi bi-folder"></i> Catalog Taxonomy</span>
        <h1 class="h2 font-display mb-1">Product Categories</h1>
        <p class="text-muted small mb-4">Organize catalog items into navigable store departments.</p>

        <!-- Add Category Form -->
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-4">
            <h2 class="h5 font-display mb-3"><i class="bi bi-folder-plus me-2 text-brand"></i>Add New Category</h2>
            <form action="${pageContext.request.contextPath}/admin/categories" method="post" class="row g-3">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                <input type="hidden" name="action" value="add">
                
                <div class="col-md-4">
                    <label class="form-label small fw-bold">Category Name</label>
                    <input class="form-control" name="name" required maxlength="100" placeholder="e.g. Wellness & Fitness">
                </div>
                <div class="col-md-8">
                    <label class="form-label small fw-bold">Description</label>
                    <input class="form-control" name="description" maxlength="500" placeholder="Brief summary of items in this department...">
                </div>
                <div class="col-12">
                    <button class="btn btn-brand" type="submit">
                        <i class="bi bi-plus-lg me-1"></i> Create Category
                    </button>
                </div>
            </form>
        </div>

        <!-- Categories Table -->
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-5">
            <h2 class="h5 font-display mb-3">Existing Categories</h2>
            <div class="table-responsive">
                <table class="table shop-table align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th>URL Slug</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>#<c:out value="${category.id}"/></td>
                                <td><strong><c:out value="${category.name}"/></strong></td>
                                <td><code><c:out value="${category.slug}"/></code></td>
                                <td>
                                    <span class="badge ${category.active ? 'bg-success-subtle text-success' : 'bg-secondary-subtle text-secondary'}">
                                        <c:out value="${category.active ? 'Active' : 'Hidden'}"/>
                                    </span>
                                </td>
                                <td class="text-end">
                                    <form action="${pageContext.request.contextPath}/admin/categories" method="post" class="d-inline">
                                        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                        <input type="hidden" name="action" value="setActive">
                                        <input type="hidden" name="id" value="${category.id}">
                                        <input type="hidden" name="active" value="${category.active ? 'false' : 'true'}">
                                        <button class="btn btn-outline-dark btn-sm rounded-pill" type="submit">
                                            <c:out value="${category.active ? 'Hide' : 'Activate'}"/>
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
