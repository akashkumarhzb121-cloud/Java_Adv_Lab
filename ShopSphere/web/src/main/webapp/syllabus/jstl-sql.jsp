<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<sql:query var="sampleProducts" dataSource="${demoDataSource}">
    SELECT id, name, price, stock FROM products WHERE active = TRUE ORDER BY name LIMIT 10
</sql:query>
<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-database-check"></i> RTU Syllabus Requirement</span>
        <h1>JSTL SQL Tag Library Demonstration</h1>
        <p class="text-muted">Direct DataSource query via &lt;sql:query&gt; in an isolated read-only sandbox.</p>
    </div>
    <a href="${pageContext.request.contextPath}/syllabus" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-arrow-left me-1"></i> Back to Syllabus Hub
    </a>
</div>

<div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-4 reveal">
    <div class="d-flex align-items-center gap-3 mb-3">
        <div class="rounded-circle bg-success-subtle text-success p-3 fs-4 d-grid place-items-center" style="width: 52px; height: 52px;">
            <i class="bi bi-table"></i>
        </div>
        <div>
            <h2 class="h5 font-display m-0">Dynamic Result Set from &lt;sql:query&gt;</h2>
            <small class="text-muted">Queried live from the connected MySQL database</small>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table shop-table align-middle">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Price (INR)</th>
                    <th>Units In Stock</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${sampleProducts.rows}">
                    <tr>
                        <td class="text-muted fw-bold">#<c:out value="${row.id}"/></td>
                        <td class="fw-semibold text-dark"><c:out value="${row.name}"/></td>
                        <td class="fw-bold">&#8377;<fmt:formatNumber value="${row.price}" minFractionDigits="2"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${row.stock gt 5}">
                                    <span class="badge bg-success-subtle text-success px-3 py-1 rounded-pill"><c:out value="${row.stock}"/> available</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-warning-subtle text-warning-emphasis px-3 py-1 rounded-pill"><c:out value="${row.stock}"/> remaining</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="card border-0 rounded-4 p-4 shadow-sm bg-white mb-5 reveal delay-1">
    <h2 class="h6 font-display mb-2"><i class="bi bi-info-circle text-primary me-2"></i>Curriculum Architectural Notice</h2>
    <p class="text-muted small mb-0">
        In commercial N-tier enterprise architectures, database queries are strictly encapsulated within the <strong>DAO (Data Access Object)</strong> layer using <code>java.sql.PreparedStatement</code> to maintain separation of concerns. This page satisfies the specific RTU curriculum objective for testing JSTL SQL capabilities.
    </p>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
