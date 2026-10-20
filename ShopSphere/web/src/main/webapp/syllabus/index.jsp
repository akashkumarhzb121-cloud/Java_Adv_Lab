<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-mortarboard-fill"></i> RTU Advanced Java & Enterprise Syllabus</span>
        <h1>Syllabus Demonstration Hub</h1>
        <p class="text-muted">Interactive verification modules demonstrating required Advanced Java curriculum topics.</p>
    </div>
</div>

<div class="row g-4 mb-5">
    <!-- Card 1: Traditional JSP Elements -->
    <div class="col-md-6 col-lg-4">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100 d-flex flex-column justify-content-between">
            <div>
                <div class="d-inline-flex p-3 rounded-4 bg-primary-subtle text-primary mb-3">
                    <i class="bi bi-filetype-jsp fs-3"></i>
                </div>
                <h2 class="h5 font-display">Traditional JSP Elements</h2>
                <p class="text-muted small">Demonstrates declaration tags (&lt;%! %&gt;), scriptlets (&lt;% %&gt;), expressions (&lt;%= %&gt;), and JSP comments (&lt;%-- --%&gt;).</p>
            </div>
            <a href="${pageContext.request.contextPath}/syllabus/traditional-jsp.jsp" class="btn btn-outline-primary btn-sm rounded-pill mt-3">
                Launch Demo →
            </a>
        </div>
    </div>

    <!-- Card 2: JSTL SQL -->
    <div class="col-md-6 col-lg-4">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100 d-flex flex-column justify-content-between">
            <div>
                <div class="d-inline-flex p-3 rounded-4 bg-success-subtle text-success mb-3">
                    <i class="bi bi-database-check fs-3"></i>
                </div>
                <h2 class="h5 font-display">JSTL SQL Demonstration</h2>
                <p class="text-muted small">Demonstrates &lt;sql:query&gt; and direct DataSource queries in an isolated academic sandbox without impacting the production DAO layer.</p>
            </div>
            <a href="${pageContext.request.contextPath}/syllabus/jstl-sql" class="btn btn-outline-success btn-sm rounded-pill mt-3">
                Launch Demo →
            </a>
        </div>
    </div>

    <!-- Card 3: JSTL XML -->
    <div class="col-md-6 col-lg-4">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100 d-flex flex-column justify-content-between">
            <div>
                <div class="d-inline-flex p-3 rounded-4 bg-warning-subtle text-warning-emphasis mb-3">
                    <i class="bi bi-filetype-xml fs-3"></i>
                </div>
                <h2 class="h5 font-display">JSTL XML Feed Parser</h2>
                <p class="text-muted small">Demonstrates &lt;x:parse&gt;, &lt;x:forEach&gt;, XPath expressions, and XML inventory product feed processing.</p>
            </div>
            <a href="${pageContext.request.contextPath}/syllabus/jstl-xml.jsp" class="btn btn-outline-warning btn-sm rounded-pill mt-3">
                Launch Demo →
            </a>
        </div>
    </div>

    <!-- Card 4: JNDI Environment Lookup -->
    <div class="col-md-6 col-lg-4">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100 d-flex flex-column justify-content-between">
            <div>
                <div class="d-inline-flex p-3 rounded-4 bg-info-subtle text-info mb-3">
                    <i class="bi bi-diagram-3-fill fs-3"></i>
                </div>
                <h2 class="h5 font-display">JNDI Environment Lookup</h2>
                <p class="text-muted small">Demonstrates javax.naming / InitialContext resource resolution for container-managed environment variables.</p>
            </div>
            <a href="${pageContext.request.contextPath}/jndi-demo" class="btn btn-outline-info btn-sm rounded-pill mt-3">
                Launch Demo →
            </a>
        </div>
    </div>

    <!-- Card 5: Servlet Lifecycle & Listeners -->
    <div class="col-md-6 col-lg-4">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100 d-flex flex-column justify-content-between">
            <div>
                <div class="d-inline-flex p-3 rounded-4 bg-danger-subtle text-danger mb-3">
                    <i class="bi bi-activity fs-3"></i>
                </div>
                <h2 class="h5 font-display">Servlet Lifecycle & Health</h2>
                <p class="text-muted small">Demonstrates init(), service(), destroy(), ServletConfig, ServletContext, and active HttpSession listeners.</p>
            </div>
            <a href="${pageContext.request.contextPath}/health" class="btn btn-outline-danger btn-sm rounded-pill mt-3">
                Launch Demo →
            </a>
        </div>
    </div>

    <!-- Card 6: Historical Applets -->
    <div class="col-md-6 col-lg-4">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100 d-flex flex-column justify-content-between">
            <div>
                <div class="d-inline-flex p-3 rounded-4 bg-secondary-subtle text-secondary mb-3">
                    <i class="bi bi-archive fs-3"></i>
                </div>
                <h2 class="h5 font-display">Applets (Curriculum Context)</h2>
                <p class="text-muted small">Historical evaluation of Java Applets, NPAPI deprecation in modern browsers, and architectural transition to Jakarta Servlets.</p>
            </div>
            <a href="${pageContext.request.contextPath}/syllabus/applet.jsp" class="btn btn-outline-secondary btn-sm rounded-pill mt-3">
                Read Analysis →
            </a>
        </div>
    </div>
</div>

<div class="card border-0 rounded-4 p-4 p-md-5 bg-dark text-white shadow-lg mb-5">
    <div class="row g-4 align-items-center">
        <div class="col-lg-8">
            <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold mb-2">Standalone Modules</span>
            <h2 class="text-white h3 font-display">Desktop & Networking Lab Modules</h2>
            <p class="text-secondary small mb-0">The RTU syllabus includes Swing GUI, java.net Socket/ServerSocket, and Java RMI Registry modules. These operate as standalone processes compiled inside the project.</p>
        </div>
        <div class="col-lg-4 text-lg-end">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-brand rounded-pill px-4">
                <i class="bi bi-arrow-left me-1"></i> Back to Storefront
            </a>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
