<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/fragments/header.jsp" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-person-circle"></i> Account Settings</span>
        <h1>Profile & Delivery Addresses</h1>
    </div>
</div>

<div class="row g-4 mb-5">
    <!-- User Personal Details -->
    <div class="col-lg-5">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <div class="d-flex align-items-center gap-3 mb-4">
                <div class="rounded-circle bg-brand text-white d-grid place-items-center fs-3 font-display shadow-sm" style="width: 58px; height: 58px; background: var(--brand);">
                    <c:out value="${fn:substring(sessionScope.user.fullName, 0, 1)}"/>
                </div>
                <div>
                    <h2 class="h5 font-display m-0"><c:out value="${sessionScope.user.fullName}"/></h2>
                    <span class="badge bg-light text-muted"><c:out value="${sessionScope.user.role}"/></span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/account/profile" method="post" class="vstack gap-3">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                <input type="hidden" name="action" value="saveProfile">
                
                <div>
                    <label class="form-label small fw-bold">Full Name</label>
                    <input class="form-control" name="fullName" value="<c:out value='${sessionScope.user.fullName}'/>" required maxlength="120">
                </div>
                <div>
                    <label class="form-label small fw-bold">Email Address</label>
                    <input class="form-control bg-light" value="<c:out value='${sessionScope.user.email}'/>" disabled>
                    <small class="text-muted">Email is permanent and tied to your account identity.</small>
                </div>
                <div>
                    <label class="form-label small fw-bold">Phone Number</label>
                    <input class="form-control" name="phone" value="<c:out value='${sessionScope.user.phone}'/>" maxlength="30" placeholder="+91 9876543210">
                </div>
                
                <button class="btn btn-brand mt-2" type="submit">
                    <i class="bi bi-check-lg me-1"></i> Update Profile
                </button>
            </form>
        </div>
    </div>

    <!-- Saved Addresses & Add Address -->
    <div class="col-lg-7">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-4">
            <h2 class="h5 font-display mb-3"><i class="bi bi-geo-alt-fill me-2 text-brand"></i>Saved Delivery Addresses</h2>
            
            <c:choose>
                <c:when test="${empty addresses}">
                    <p class="text-muted small">No delivery addresses saved yet. Add your first address below for faster checkout.</p>
                </c:when>
                <c:otherwise>
                    <div class="vstack gap-2 mb-4">
                        <c:forEach var="address" items="${addresses}">
                            <div class="address-row p-3 border rounded-3 d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge bg-light text-dark fw-bold me-1"><c:out value="${address.label}"/></span>
                                    <p class="mb-0 small text-secondary mt-1">
                                        <c:out value="${address.line1}"/> <c:out value="${address.line2}"/>,
                                        <c:out value="${address.city}"/>, <c:out value="${address.state}"/> - <c:out value="${address.postalCode}"/>,
                                        <c:out value="${address.country}"/>
                                    </p>
                                </div>
                                <form action="${pageContext.request.contextPath}/account/profile" method="post" class="m-0">
                                    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                    <input type="hidden" name="action" value="deleteAddress">
                                    <input type="hidden" name="addressId" value="${address.id}">
                                    <button class="btn btn-outline-danger btn-sm rounded-pill" type="submit" title="Delete address">
                                        <i class="bi bi-trash3"></i>
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

            <h3 class="h6 font-display mt-2 mb-3">Add a New Address</h3>
            <form action="${pageContext.request.contextPath}/account/profile" method="post" class="row g-2">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                <input type="hidden" name="action" value="addAddress">
                
                <div class="col-md-4">
                    <input class="form-control form-control-sm" name="label" placeholder="Label (e.g. Home, Office)" required maxlength="40">
                </div>
                <div class="col-md-8">
                    <input class="form-control form-control-sm" name="line1" placeholder="Address Line 1" required maxlength="180">
                </div>
                <div class="col-12">
                    <input class="form-control form-control-sm" name="line2" placeholder="Address Line 2 (Optional)" maxlength="180">
                </div>
                <div class="col-md-6">
                    <input class="form-control form-control-sm" name="city" placeholder="City" required maxlength="100">
                </div>
                <div class="col-md-6">
                    <input class="form-control form-control-sm" name="state" placeholder="State" required maxlength="100">
                </div>
                <div class="col-md-6">
                    <input class="form-control form-control-sm" name="postalCode" placeholder="Postal Code" required maxlength="20">
                </div>
                <div class="col-md-6">
                    <input class="form-control form-control-sm" name="country" value="India" required maxlength="80">
                </div>
                <div class="col-12 mt-2">
                    <button class="btn btn-outline-dark btn-sm rounded-pill px-3" type="submit">
                        <i class="bi bi-plus-lg me-1"></i> Save Address
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
