<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout">
    <%@ include file="/WEB-INF/fragments/sidebar.jsp" %>
    <section class="admin-content">
        <span class="eyebrow"><i class="bi bi-people"></i> Identity Management</span>
        <h1 class="h2 font-display mb-1">Customer Accounts</h1>
        <p class="text-muted small mb-4">Review registered shoppers, roles and manage account status.</p>

        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-5">
            <div class="table-responsive">
                <table class="table shop-table align-middle">
                    <thead>
                        <tr>
                            <th>User Name</th>
                            <th>Email Address</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th class="text-end">Account Controls</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="account" items="${users}">
                            <tr>
                                <td>
                                    <strong><c:out value="${account.user.fullName}"/></strong>
                                </td>
                                <td><c:out value="${account.user.email}"/></td>
                                <td><c:out value="${account.user.phone != null ? account.user.phone : '—'}"/></td>
                                <td>
                                    <span class="badge ${account.user.role == 'ADMIN' ? 'bg-primary-subtle text-primary' : 'bg-light text-dark'}">
                                        <c:out value="${account.user.role}"/>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge ${account.active ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'}">
                                        <c:out value="${account.active ? 'Active' : 'Suspended'}"/>
                                    </span>
                                </td>
                                <td class="text-end">
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline">
                                        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                        <input type="hidden" name="userId" value="${account.user.id}">
                                        <input type="hidden" name="action" value="${account.active ? 'deactivate' : 'activate'}">
                                        <button class="btn btn-outline-${account.active ? 'danger' : 'success'} btn-sm rounded-pill px-3" type="submit">
                                            <c:out value="${account.active ? 'Deactivate' : 'Activate'}"/>
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
