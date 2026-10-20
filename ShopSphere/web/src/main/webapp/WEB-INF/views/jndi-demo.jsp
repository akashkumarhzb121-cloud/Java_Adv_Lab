<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-diagram-3-fill"></i> RTU Syllabus Requirement</span>
        <h1>JNDI Naming & Directory Service</h1>
        <p class="text-muted">Demonstration of javax.naming / InitialContext enterprise resource lookup.</p>
    </div>
    <a href="${pageContext.request.contextPath}/syllabus" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-arrow-left me-1"></i> Back to Syllabus Hub
    </a>
</div>

<div class="card border-0 rounded-4 p-5 shadow-sm bg-white text-center mb-5 reveal" style="max-width: 680px; margin: 0 auto;">
    <div class="d-inline-flex p-4 rounded-circle bg-info-subtle text-info mx-auto mb-3" style="width: 80px; height: 80px; align-items: center; justify-content: center;">
        <i class="bi bi-diagram-3 fs-1"></i>
    </div>
    <span class="badge bg-success-subtle text-success px-3 py-1 rounded-pill mb-2 fw-semibold">
        <i class="bi bi-check-circle-fill me-1"></i> JNDI Context Resolution Successful
    </span>
    <h2 class="h4 font-display text-dark my-2"><c:out value="${greeting}"/></h2>
    <p class="text-muted small mb-4">
        The application successfully looked up the configured environment resource <code>java:comp/env/greeting</code> using Tomcat's JNDI <code>InitialContext</code>.
    </p>
    <div>
        <a class="btn btn-brand rounded-pill px-4" href="${pageContext.request.contextPath}/syllabus">
            Return to Syllabus Hub
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
