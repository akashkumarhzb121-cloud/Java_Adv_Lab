<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-activity"></i> RTU Syllabus Concept</span>
        <h1>Servlet Lifecycle &amp; Container Health</h1>
        <p class="text-muted">Demonstration of ServletConfig, ServletContext, init(), service(), and container telemetry.</p>
    </div>
    <a href="${pageContext.request.contextPath}/syllabus" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-arrow-left me-1"></i> Back to Syllabus Hub
    </a>
</div>

<div class="row g-4 mb-5 reveal">
    <!-- Overall Health Status -->
    <div class="col-12">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="rounded-circle bg-success-subtle text-success p-3 fs-3 d-grid place-items-center" style="width: 60px; height: 60px;">
                    <i class="bi bi-check-circle-fill"></i>
                </div>
                <div>
                    <h2 class="h5 font-display m-0 text-success"><c:out value="${component}"/> Operational</h2>
                    <small class="text-muted">HTTP 200 OK &bull; All servlet subsystems &amp; listeners healthy</small>
                </div>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/health?format=text" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                    <i class="bi bi-terminal me-1"></i> View Raw Plaintext
                </a>
            </div>
        </div>
    </div>

    <!-- Telemetry Cards -->
    <div class="col-md-6 col-lg-3">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <span class="text-muted small text-uppercase fw-semibold mb-1">Web Container</span>
            <strong class="fs-6 text-dark font-display"><c:out value="${serverInfo}"/></strong>
            <small class="text-secondary mt-2"><i class="bi bi-server me-1"></i> Servlet 6.1 Container</small>
        </div>
    </div>

    <div class="col-md-6 col-lg-3">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <span class="text-muted small text-uppercase fw-semibold mb-1">Java Runtime</span>
            <strong class="fs-6 text-dark font-display">JDK <c:out value="${jvmVersion}"/></strong>
            <small class="text-secondary mt-2"><i class="bi bi-cpu me-1"></i> <c:out value="${osName}"/></small>
        </div>
    </div>

    <div class="col-md-6 col-lg-3">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <span class="text-muted small text-uppercase fw-semibold mb-1">JVM Heap Memory</span>
            <strong class="fs-6 text-dark font-display"><c:out value="${freeMemoryMB}"/> MB / <c:out value="${totalMemoryMB}"/> MB</strong>
            <small class="text-secondary mt-2"><i class="bi bi-memory me-1"></i> Max: <c:out value="${maxMemoryMB}"/> MB</small>
        </div>
    </div>

    <div class="col-md-6 col-lg-3">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <span class="text-muted small text-uppercase fw-semibold mb-1">Active Threads</span>
            <strong class="fs-6 text-dark font-display"><c:out value="${activeThreads}"/> Running</strong>
            <small class="text-success mt-2"><i class="bi bi-check2-circle me-1"></i> Managed thread pool</small>
        </div>
    </div>

    <!-- Lifecycle Architecture Documentation -->
    <div class="col-12">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white">
            <h2 class="h5 font-display mb-3"><i class="bi bi-arrow-repeat text-brand me-2"></i>Servlet Lifecycle in ShopSphere</h2>
            <div class="row g-3">
                <div class="col-md-4">
                    <div class="p-3 bg-light rounded-3 h-100">
                        <span class="badge bg-primary mb-2">Phase 1: Loading &amp; Init</span>
                        <h3 class="h6 font-display">init(ServletConfig config)</h3>
                        <p class="text-muted small mb-0">The web container instantiates the servlet and loads configured <code>&lt;init-param&gt;</code> values before handling any requests.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3 bg-light rounded-3 h-100">
                        <span class="badge bg-success mb-2">Phase 2: Request Handling</span>
                        <h3 class="h6 font-display">service(HttpServletRequest, ...)</h3>
                        <p class="text-muted small mb-0">Dispatches incoming concurrent HTTP requests to <code>doGet()</code>, <code>doPost()</code>, etc. inside separate threads.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3 bg-light rounded-3 h-100">
                        <span class="badge bg-danger mb-2">Phase 3: Destruction</span>
                        <h3 class="h6 font-display">destroy()</h3>
                        <p class="text-muted small mb-0">Called when the web application undeploys or the container shuts down to release resources and log clean shutdown.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
