<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="section-heading"><div><span class="eyebrow">Your ShopSphere</span><h1>Profile & addresses</h1></div></div>
<div class="row g-4"><div class="col-lg-5"><form action="${pageContext.request.contextPath}/account/profile" method="post" class="summary-card">
    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="saveProfile"><h2>Profile details</h2>
    <label>Full name<input class="form-control" name="fullName" value="<c:out value='${sessionScope.user.fullName}'/>" required maxlength="120"></label>
    <label>Email<input class="form-control" value="<c:out value='${sessionScope.user.email}'/>" disabled></label>
    <label>Phone<input class="form-control" name="phone" value="<c:out value='${sessionScope.user.phone}'/>" maxlength="30"></label>
    <button class="btn btn-brand mt-3" type="submit">Save profile</button>
</form></div>
<div class="col-lg-7"><div class="summary-card"><h2>Saved addresses</h2>
    <c:forEach var="address" items="${addresses}"><div class="address-row"><div><strong><c:out value="${address.label}"/></strong><p class="mb-0"><c:out value="${address.line1}"/> <c:out value="${address.line2}"/>, <c:out value="${address.city}"/>, <c:out value="${address.state}"/> <c:out value="${address.postalCode}"/>, <c:out value="${address.country}"/></p></div>
        <form action="${pageContext.request.contextPath}/account/profile" method="post"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="deleteAddress"><input type="hidden" name="addressId" value="${address.id}"><button class="btn btn-link text-danger" type="submit">Remove</button></form></div></c:forEach>
    <h3 class="mt-4">Add an address</h3><form action="${pageContext.request.contextPath}/account/profile" method="post" class="row g-2">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="addAddress">
        <div class="col-md-4"><input class="form-control" name="label" placeholder="Label e.g. Home" required maxlength="40"></div>
        <div class="col-md-8"><input class="form-control" name="line1" placeholder="Address line 1" required maxlength="180"></div>
        <div class="col-12"><input class="form-control" name="line2" placeholder="Address line 2" maxlength="180"></div>
        <div class="col-md-6"><input class="form-control" name="city" placeholder="City" required maxlength="100"></div>
        <div class="col-md-6"><input class="form-control" name="state" placeholder="State" required maxlength="100"></div>
        <div class="col-md-6"><input class="form-control" name="postalCode" placeholder="Postal code" required maxlength="20"></div>
        <div class="col-md-6"><input class="form-control" name="country" value="India" required maxlength="80"></div>
        <div class="col-12"><button class="btn btn-outline-dark" type="submit">Add address</button></div>
    </form>
</div></div></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
