<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<%! int viewCount = 0; %>
<%
    viewCount++;
    String demonstrationTitle = "Traditional JSP Syntax Demonstration";
    LocalDate demonstrationDate = LocalDate.now();
%>
<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-filetype-jsp"></i> RTU Syllabus Requirement</span>
        <h1><%= demonstrationTitle %></h1>
        <p class="text-muted">Demonstration of classic JSP elements: Declarations, Scriptlets, Expressions, and Server-Side Comments.</p>
    </div>
    <a href="${pageContext.request.contextPath}/syllabus" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-arrow-left me-1"></i> Back to Syllabus Hub
    </a>
</div>

<div class="row g-4 mb-5 reveal">
    <!-- Declaration & Expression Demonstration -->
    <div class="col-md-6">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <div class="d-flex align-items-center gap-3 mb-3">
                <div class="rounded-circle bg-primary-subtle text-primary p-3 fs-4 d-grid place-items-center" style="width: 52px; height: 52px;">
                    <i class="bi bi-braces"></i>
                </div>
                <div>
                    <h2 class="h5 font-display m-0">JSP Declarations &lt;%! ... %&gt;</h2>
                    <small class="text-muted">Class-level member variables &amp; methods</small>
                </div>
            </div>
            <p class="text-secondary small">
                Declarations become member fields of the generated servlet class, persisting across multiple HTTP requests to the same JVM instance.
            </p>
            <div class="p-3 bg-light rounded-3 font-monospace small mb-3">
                &lt;%! int viewCount = 0; %&gt;
            </div>
            <div class="p-3 bg-primary-subtle rounded-3 d-flex justify-content-between align-items-center">
                <span class="fw-semibold text-primary-emphasis">Declaration-backed hit counter:</span>
                <span class="badge bg-primary fs-6 px-3 py-2 rounded-pill"><%= viewCount %> views</span>
            </div>
        </div>
    </div>

    <!-- Scriptlet & Expression Demonstration -->
    <div class="col-md-6">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <div class="d-flex align-items-center gap-3 mb-3">
                <div class="rounded-circle bg-success-subtle text-success p-3 fs-4 d-grid place-items-center" style="width: 52px; height: 52px;">
                    <i class="bi bi-code-slash"></i>
                </div>
                <div>
                    <h2 class="h5 font-display m-0">JSP Scriptlets &lt;% ... %&gt;</h2>
                    <small class="text-muted">Inlined Java statements inside _jspService()</small>
                </div>
            </div>
            <p class="text-secondary small">
                Scriptlets are placed inside the servlet's <code>_jspService()</code> method and execute dynamically on every client request.
            </p>
            <div class="p-3 bg-light rounded-3 font-monospace small mb-3">
                &lt;% LocalDate demonstrationDate = LocalDate.now(); %&gt;
            </div>
            <div class="p-3 bg-success-subtle rounded-3 d-flex justify-content-between align-items-center">
                <span class="fw-semibold text-success-emphasis">Expression &lt;%= ... %&gt; Output:</span>
                <span class="badge bg-success fs-6 px-3 py-2 rounded-pill"><%= demonstrationDate %></span>
            </div>
        </div>
    </div>

    <!-- Syllabus Architecture Note -->
    <div class="col-12">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white">
            <h2 class="h5 font-display mb-2"><i class="bi bi-shield-check text-brand me-2"></i>Curriculum Best Practices</h2>
            <%-- JSP comment: declarations, scriptlets and expressions are shown here specifically to fulfill the RTU syllabus requirement. --%>
            <p class="text-muted mb-0">
                While traditional JSP scriptlets are supported and required for RTU Advanced Java practicals, the main <strong>ShopSphere</strong> production application uses the modern standard: <strong>Jakarta Servlets</strong> for controllers, <strong>JSP Expression Language (EL 6.0)</strong>, and <strong>JSTL 3.0</strong> for robust separation of presentation and business logic.
            </p>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
