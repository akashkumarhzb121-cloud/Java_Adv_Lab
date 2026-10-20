<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="empty-state card border-0 rounded-4 p-5 shadow text-center bg-white my-4 reveal">
    <div class="checkmark-circle mx-auto">
        <div class="background"></div>
        <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
            <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
        </svg>
    </div>
    <span class="eyebrow"><i class="bi bi-patch-check-fill"></i> Order Confirmed</span>
    <h1 class="font-display mt-2 mb-2">Thank you for your purchase!</h1>
    <p class="text-muted lead fs-6 mb-4">Your order is being processed by our automated fulfillment center.</p>
    <div class="d-flex justify-content-center gap-3">
        <a class="btn btn-brand btn-lg rounded-pill px-4" href="${pageContext.request.contextPath}/orders">
            <i class="bi bi-box-seam me-2"></i> Track My Orders
        </a>
        <a class="btn btn-outline-dark btn-lg rounded-pill px-4" href="${pageContext.request.contextPath}/products">
            <i class="bi bi-bag me-2"></i> Browse More
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
