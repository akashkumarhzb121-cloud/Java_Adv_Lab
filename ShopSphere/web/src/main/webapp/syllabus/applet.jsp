<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-archive-fill"></i> RTU Syllabus Concept</span>
        <h1>Java Applets — Historical Demonstration</h1>
        <p class="text-muted">Analysis of Java Applets, browser security deprecation, and modern full-stack web architectures.</p>
    </div>
    <a href="${pageContext.request.contextPath}/syllabus" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-arrow-left me-1"></i> Back to Syllabus Hub
    </a>
</div>

<div class="row g-4 mb-5 reveal">
    <div class="col-lg-6">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <h2 class="h5 font-display mb-3"><i class="bi bi-code-square me-2 text-primary"></i>Traditional Applet Markup</h2>
            <p class="text-muted small">
                In classical Java Enterprise development (JDK 1.1–8), client-side interactive graphics were embedded using the HTML <code>&lt;applet&gt;</code> tag and loaded through the NPAPI browser plugin:
            </p>
            <pre class="bg-light p-3 rounded-3 small font-monospace text-secondary mb-3">
&lt;applet code="ShopBannerApplet.class" width="480" height="160"&gt;
    &lt;param name="store" value="ShopSphere"/&gt;
    &lt;param name="theme" value="modern-forest"/&gt;
&lt;/applet&gt;</pre>
            <div class="alert alert-info py-2 px-3 small rounded-3 mb-0">
                <i class="bi bi-info-circle me-1"></i> Modern browsers permanently removed NPAPI plugin support in favor of HTML5 Canvas, JavaScript, and WebAssembly.
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <h2 class="h5 font-display mb-3"><i class="bi bi-play-circle-fill me-2 text-success"></i>Interactive Canvas Simulation</h2>
            <p class="text-muted small">
                Simulating the visual applet lifecycle (<code>init()</code>, <code>start()</code>, <code>paint()</code>) inside an HTML5 interactive canvas:
            </p>
            <canvas id="legacy" width="600" height="200" style="border-radius: 1rem; background: #0c1c18; display: block; width: 100%; height: auto; box-shadow: inset 0 2px 10px rgba(0,0,0,0.4);" aria-label="Animated banner replacing a Java applet"></canvas>
        </div>
    </div>
</div>

<script>
    (function() {
        const canvas = document.getElementById("legacy");
        if (!canvas) return;
        const ctx = canvas.getContext("2d");
        let t = 0;
        const draw = () => {
            t += 0.02;
            ctx.fillStyle = "#0c1c18";
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = "#19d19a";
            ctx.beginPath();
            ctx.arc(120 + Math.sin(t) * 40, 100, 32, 0, Math.PI * 2);
            ctx.fill();
            ctx.fillStyle = "#ffffff";
            ctx.font = "bold 20px 'Plus Jakarta Sans', sans-serif";
            ctx.fillText("ShopSphere: Applet Era \u2192 Modern Java EE", 180, 106);
            requestAnimationFrame(draw);
        };
        draw();
    })();
</script>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
