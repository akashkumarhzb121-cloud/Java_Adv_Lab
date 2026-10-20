<%@ include file="/WEB-INF/fragments/header.jsp" %>

<section class="auth-card card border-0 rounded-4 p-4 p-md-5 shadow-lg bg-white my-5 mx-auto reveal" style="max-width: 500px;">
    <div class="text-center mb-4">
        <span class="brand-logo-icon mb-2"><i class="bi bi-person-plus-fill"></i></span>
        <span class="eyebrow d-block mt-2"><i class="bi bi-stars"></i> New Member</span>
        <h1 class="h3 font-display mt-1">Create your Account</h1>
        <p class="text-muted small">Join ShopSphere to enjoy streamlined shopping, order tracking and member coupons.</p>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/register" class="vstack gap-3">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
        
        <div>
            <label class="form-label small fw-bold">Full Name</label>
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person"></i></span>
                <input class="form-control border-start-0" name="fullName" autocomplete="name" required maxlength="120" placeholder="e.g. Akash Kumar">
            </div>
        </div>

        <div>
            <label class="form-label small fw-bold">Email Address</label>
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope"></i></span>
                <input class="form-control border-start-0" type="email" name="email" autocomplete="email" required maxlength="254" placeholder="akash@example.com">
            </div>
        </div>

        <div>
            <label class="form-label small fw-bold">Password</label>
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock"></i></span>
                <input class="form-control border-start-0" type="password" name="password" autocomplete="new-password" minlength="10" maxlength="128" required placeholder="At least 10 characters">
            </div>
            <small class="text-muted d-block mt-1">
                <i class="bi bi-shield-check text-success me-1"></i> Passwords are protected using salted PBKDF2-SHA256.
            </small>
        </div>

        <button class="btn btn-brand btn-lg w-100 shadow mt-2" type="submit">
            Create Account <i class="bi bi-arrow-right ms-1"></i>
        </button>
    </form>

    <div class="text-center mt-4 pt-3 border-top small text-muted">
        Already registered with ShopSphere?
        <a href="${pageContext.request.contextPath}/login" class="fw-bold ms-1">Sign in here</a>
    </div>
</section>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
