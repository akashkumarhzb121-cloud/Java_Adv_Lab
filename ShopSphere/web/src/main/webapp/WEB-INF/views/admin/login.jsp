<%@ include file="/WEB-INF/fragments/header.jsp" %>

<section class="auth-card card border-0 rounded-4 p-4 p-md-5 shadow-lg bg-white my-5 mx-auto reveal" style="max-width: 480px;">
    <div class="text-center mb-4">
        <span class="brand-logo-icon mb-2 bg-dark"><i class="bi bi-shield-lock-fill"></i></span>
        <span class="eyebrow d-block mt-2"><i class="bi bi-shield-check text-danger"></i> Restricted Console</span>
        <h1 class="h3 font-display mt-1">Administrator Sign In</h1>
        <p class="text-muted small">Store control center for orders, inventory and product management.</p>
    </div>

    <!-- 1-Click Quick Fill Admin Demo Button -->
    <div class="p-3 bg-light rounded-4 mb-4 border border-light-subtle d-flex justify-content-between align-items-center">
        <div>
            <span class="small fw-bold text-dark d-block">Admin Demo Account:</span>
            <small class="text-muted"><code>admin@shopsphere.local</code></small>
        </div>
        <button type="button" class="btn btn-outline-dark btn-sm rounded-pill px-3"
                onclick="document.getElementById('adminEmail').value='admin@shopsphere.local';document.getElementById('adminPass').value='Admin@ShopSphere25';">
            Fill Credentials
        </button>
    </div>

    <form action="${pageContext.request.contextPath}/admin/login" method="post" class="vstack gap-3">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
        
        <div>
            <label class="form-label small fw-bold">Admin Email</label>
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-badge"></i></span>
                <input class="form-control border-start-0" type="email" id="adminEmail" name="email" required maxlength="254" placeholder="admin@shopsphere.local">
            </div>
        </div>

        <div>
            <label class="form-label small fw-bold">Master Password</label>
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0"><i class="bi bi-key"></i></span>
                <input class="form-control border-start-0" type="password" id="adminPass" name="password" required placeholder="Enter password">
            </div>
        </div>

        <button class="btn btn-brand btn-lg w-100 shadow mt-2" type="submit">
            <i class="bi bi-shield-lock me-1"></i> Access Admin Console
        </button>
    </form>

    <div class="text-center mt-4 pt-3 border-top small text-muted">
        <a href="${pageContext.request.contextPath}/home" class="text-secondary"><i class="bi bi-arrow-left me-1"></i> Return to Customer Store</a>
    </div>
</section>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
