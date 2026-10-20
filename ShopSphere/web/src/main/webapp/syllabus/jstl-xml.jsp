<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="x" uri="jakarta.tags.xml" %>
<x:parse var="sample">
    <catalog>
        <item>
            <id>SKU-101</id>
            <name>Acoustic Studio Monitors</name>
            <category>Electronics</category>
            <price>12999</price>
        </item>
        <item>
            <id>SKU-102</id>
            <name>Ergonomic Desk Chair</name>
            <category>Furniture</category>
            <price>8499</price>
        </item>
        <item>
            <id>SKU-103</id>
            <name>Mechanical Keyboard</name>
            <category>Accessories</category>
            <price>3299</price>
        </item>
    </catalog>
</x:parse>
<%@ include file="/WEB-INF/fragments/header.jsp" %>

<div class="section-heading">
    <div>
        <span class="eyebrow"><i class="bi bi-filetype-xml"></i> RTU Syllabus Requirement</span>
        <h1>JSTL XML Tag Library Demonstration</h1>
        <p class="text-muted">Parsing XML documents and executing XPath queries via &lt;x:parse&gt;, &lt;x:out&gt;, and &lt;x:forEach&gt;.</p>
    </div>
    <a href="${pageContext.request.contextPath}/syllabus" class="btn btn-outline-dark btn-sm rounded-pill px-3">
        <i class="bi bi-arrow-left me-1"></i> Back to Syllabus Hub
    </a>
</div>

<div class="row g-4 mb-5 reveal">
    <div class="col-lg-6">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <div class="d-flex align-items-center gap-3 mb-3">
                <div class="rounded-circle bg-warning-subtle text-warning-emphasis p-3 fs-4 d-grid place-items-center" style="width: 52px; height: 52px;">
                    <i class="bi bi-file-code"></i>
                </div>
                <div>
                    <h2 class="h5 font-display m-0">In-Memory XML Feed Data</h2>
                    <small class="text-muted">Simulated supplier B2B inventory document</small>
                </div>
            </div>
            <pre class="bg-light p-3 rounded-3 small font-monospace text-secondary" style="max-height: 280px; overflow-y: auto;">
&lt;catalog&gt;
  &lt;item&gt;
    &lt;id&gt;SKU-101&lt;/id&gt;
    &lt;name&gt;Acoustic Studio Monitors&lt;/name&gt;
    &lt;category&gt;Electronics&lt;/category&gt;
    &lt;price&gt;12999&lt;/price&gt;
  &lt;/item&gt;
  &lt;item&gt;
    &lt;id&gt;SKU-102&lt;/id&gt;
    &lt;name&gt;Ergonomic Desk Chair&lt;/name&gt;
    &lt;category&gt;Furniture&lt;/category&gt;
    &lt;price&gt;8499&lt;/price&gt;
  &lt;/item&gt;
  &lt;item&gt;
    &lt;id&gt;SKU-103&lt;/id&gt;
    &lt;name&gt;Mechanical Keyboard&lt;/name&gt;
    &lt;category&gt;Accessories&lt;/category&gt;
    &lt;price&gt;3299&lt;/price&gt;
  &lt;/item&gt;
&lt;/catalog&gt;</pre>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="card border-0 rounded-4 p-4 shadow-sm bg-white h-100">
            <div class="d-flex align-items-center gap-3 mb-3">
                <div class="rounded-circle bg-primary-subtle text-primary p-3 fs-4 d-grid place-items-center" style="width: 52px; height: 52px;">
                    <i class="bi bi-diagram-3"></i>
                </div>
                <div>
                    <h2 class="h5 font-display m-0">Parsed XPath Nodes via JSTL</h2>
                    <small class="text-muted">Rendered with &lt;x:forEach select="$sample/catalog/item"&gt;</small>
                </div>
            </div>
            
            <div class="vstack gap-3">
                <x:forEach select="$sample/catalog/item">
                    <div class="p-3 border rounded-3 bg-white d-flex justify-content-between align-items-center">
                        <div>
                            <span class="badge bg-light text-muted me-2"><x:out select="id"/></span>
                            <strong class="text-dark"><x:out select="name"/></strong>
                            <div class="text-muted small"><x:out select="category"/></div>
                        </div>
                        <span class="fw-bold text-brand fs-5">&#8377;<x:out select="price"/></span>
                    </div>
                </x:forEach>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jsp" %>
