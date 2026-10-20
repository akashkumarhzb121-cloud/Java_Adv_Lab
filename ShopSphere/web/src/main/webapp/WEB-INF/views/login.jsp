<%@ include file="/WEB-INF/fragments/header.jsp" %>

<section class="auth-card card border-0 rounded-4 p-4 p-md-5 shadow-lg bg-white my-5 mx-auto reveal" style="max-width: 480px;">
    <div class="text-center mb-4">
        <span class="brand-logo-icon mb-2"><i class="bi bi-box2-heart-fill"></i></span>
        <span class="eyebrow d-block mt-2"><i class="bi bi-shield-check"></i> Account Access</span>
        <h1 class="h3 font-display mt-1">Sign in to ShopSphere</h1>
        <p class="text-muted small">Access your cart, order history and saved delivery addresses.</p>
    </div>

    <!-- Quick-Fill Demo Credentials Buttons -->
    <div class="p-3 bg-light rounded-4 mb-4 border border-light-subtle">
        <span class="small fw-bold text-dark d-block mb-2"><i class="bi bi-key-fill text-warning me-1"></i> Quick Test Accounts:</span>
        <div class="d-flex gap-2">
            <button type="button" class="btn btn-outline-secondary btn-sm flex-grow-1 rounded-pill"
                    onclick="document.getElementById('loginEmail').value='customer@shopsphere.local';document.getElementById('loginPass').value='Customer@ShopSphere25';">
                Customer Demo
            </button>
            <button type="button" class="btn btn-outline-secondary btn-sm flex-grow-1 rounded-pill"
                    onclick="document.getElementById('loginEmail').value='admin@shopsphere.local';document.getElementById('loginPass').value='Admin@ShopSphere25';">
                Admin Demo
            </button>
        </div>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/login" class="vstack gap-3">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
        
        <div>
            <label class="form-label small fw-bold">Email Address</label>
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope"></i></span>
                <input class="form-control border-start-0" type="email" id="loginEmail" name="email" autocomplete="email" required maxlength="254" placeholder="user@example.com">
            </div>
        </div>

        <div>
            <label class="form-label small fw-bold">Password</label>
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock"></i></span>
                <input class="form-control border-start-0" type="password" id="loginPass" name="password" autocomplete="current-password" required placeholder="Enter your password">
            </div>
        </div>

        <button class="btn btn-brand btn-lg w-100 shadow mt-2" type="submit">
            Sign In <i class="bi bi-arrow-right ms-1"></i>
        </button>
    </form>

    <div class="text-center mt-4 pt-3 border-top small text-muted">
        Don't have an account yet?
        <a href="${pageContext.request.contextPath}/register" class="fw-bold ms-1">Create one here</a>
    </div>
</section>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
