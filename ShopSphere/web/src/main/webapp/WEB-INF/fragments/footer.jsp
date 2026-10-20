</main>

<!-- Floating Back to Top Button -->
<button type="button" class="btn-back-to-top shadow-lg" id="btnBackToTop" aria-label="Back to top">
    <i class="bi bi-arrow-up"></i>
</button>

<footer class="site-footer mt-auto">
    <div class="container">
        <div class="footer-grid py-5">
            <div>
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="brand-logo-icon"><i class="bi bi-box2-heart-fill"></i></span>
                    <h2 class="h4 text-white m-0 font-display">Shop<span class="brand-accent">Sphere</span></h2>
                </div>
                <p class="text-secondary small mb-3" style="max-width: 320px;">
                    A premier full-stack Java E-Commerce application architected with Jakarta EE, JDBC, MySQL, Swing, Sockets & RMI.
                </p>
                <div class="d-flex gap-3 text-secondary fs-5">
                    <a href="https://github.com" target="_blank" rel="noreferrer" class="text-secondary footer-social"><i class="bi bi-github"></i></a>
                    <a href="https://linkedin.com" target="_blank" rel="noreferrer" class="text-secondary footer-social"><i class="bi bi-linkedin"></i></a>
                    <a href="mailto:support@shopsphere.local" class="text-secondary footer-social"><i class="bi bi-envelope"></i></a>
                </div>
            </div>
            <div>
                <h3 class="h6 text-white text-uppercase tracking-wider mb-3">Store Navigation</h3>
                <ul class="list-unstyled footer-links vstack gap-2 small">
                    <li><a href="${pageContext.request.contextPath}/home"><i class="bi bi-chevron-right me-1"></i> Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/products"><i class="bi bi-chevron-right me-1"></i> Catalog & Search</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart"><i class="bi bi-chevron-right me-1"></i> Shopping Cart</a></li>
                    <li><a href="${pageContext.request.contextPath}/orders"><i class="bi bi-chevron-right me-1"></i> Order History & Tracking</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin"><i class="bi bi-chevron-right me-1"></i> Desktop & Web Admin</a></li>
                </ul>
            </div>
            <div>
                <h3 class="h6 text-white text-uppercase tracking-wider mb-3">RTU Syllabus Demos</h3>
                <ul class="list-unstyled footer-links vstack gap-2 small">
                    <li><a href="${pageContext.request.contextPath}/syllabus/index.jsp"><i class="bi bi-stars me-1 text-warning"></i> Syllabus Topic Hub</a></li>
                    <li><a href="${pageContext.request.contextPath}/syllabus/traditional-jsp.jsp"><i class="bi bi-code-slash me-1"></i> Scriptlets & Declarations</a></li>
                    <li><a href="${pageContext.request.contextPath}/syllabus/jstl-sql"><i class="bi bi-database me-1"></i> JSTL SQL Demonstration</a></li>
                    <li><a href="${pageContext.request.contextPath}/syllabus/jstl-xml.jsp"><i class="bi bi-filetype-xml me-1"></i> JSTL XML Parsing</a></li>
                    <li><a href="${pageContext.request.contextPath}/jndi-demo"><i class="bi bi-diagram-3 me-1"></i> JNDI Lookup Demo</a></li>
                    <li><a href="${pageContext.request.contextPath}/health"><i class="bi bi-activity me-1"></i> Servlet Lifecycle & Health</a></li>
                </ul>
            </div>
        </div>
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2 py-3 border-top border-secondary border-opacity-25 small text-secondary">
            <span>&copy; 2026 <strong>ShopSphere</strong> &middot; Built for RTU Advanced Java / Java Enterprise</span>
            <div class="d-flex gap-3">
                <span><i class="bi bi-shield-check text-success me-1"></i> PBKDF2 Encrypted</span>
                <span><i class="bi bi-credit-card text-info me-1"></i> Mock Payment</span>
                <span><i class="bi bi-truck text-warning me-1"></i> Express Fulfillment</span>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/shopsphere.js"></script>
</body>
</html>
