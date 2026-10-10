<%@ include file="/WEB-INF/fragments/header.jsp" %>
<div class="admin-layout"><%@ include file="/WEB-INF/fragments/sidebar.jsp" %><section class="admin-content">
    <span class="eyebrow">Promotions</span><h1>Coupons</h1>
    <form action="${pageContext.request.contextPath}/admin/coupons" method="post" class="summary-card row g-3 mb-4">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
        <div class="col-md-4"><label>Code<input class="form-control" name="code" required maxlength="40" placeholder="SPRING15"></label></div>
        <div class="col-md-4"><label>Discount %<input class="form-control" name="discountPercent" type="number" min="0.01" max="100" step="0.01" required></label></div>
        <div class="col-md-4"><label>Minimum order (₹)<input class="form-control" name="minimumOrder" type="number" min="0" step="0.01" value="0" required></label></div>
        <div class="col-12"><button class="btn btn-brand" type="submit">Create coupon (valid for one year)</button></div>
    </form>
    <div class="table-responsive"><table class="table shop-table"><thead><tr><th>Code</th><th>Discount</th><th>Minimum order</th><th>Status</th><th></th></tr></thead><tbody>
        <c:forEach var="coupon" items="${coupons}"><tr><td><c:out value="${coupon.code}"/></td><td><c:out value="${coupon.discountPercent}"/>%</td><td>₹<fmt:formatNumber value="${coupon.minimumOrder}"/></td><td><c:out value="${coupon.active ? 'Active' : 'Inactive'}"/></td><td>
            <form action="${pageContext.request.contextPath}/admin/coupons" method="post"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><input type="hidden" name="action" value="setActive"><input type="hidden" name="id" value="${coupon.id}"><input type="hidden" name="active" value="${coupon.active ? 'false' : 'true'}"><button class="btn btn-outline-dark btn-sm" type="submit">${coupon.active ? 'Deactivate' : 'Activate'}</button></form>
        </td></tr></c:forEach>
    </tbody></table></div>
</section></div>
<%@ include file="/WEB-INF/fragments/footer.jsp" %>
