<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<sql:query var="sampleProducts" dataSource="${demoDataSource}">
    SELECT id, name, price, stock FROM products WHERE active = TRUE ORDER BY name LIMIT 10
</sql:query>
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>JSTL SQL demo</title></head>
<body><h1>JSTL SQL syllabus demonstration</h1>
    <p>This read-only example is isolated from the main JSP → Servlet → Service → DAO flow.</p>
    <table><thead><tr><th>Product</th><th>Price (INR)</th><th>Available</th></tr></thead><tbody>
    <c:forEach var="row" items="${sampleProducts.rows}">
        <tr><td><c:out value="${row.name}"/></td><td><c:out value="${row.price}"/></td><td><c:out value="${row.stock}"/></td></tr>
    </c:forEach>
    </tbody></table><a href="${pageContext.request.contextPath}/products">Return to ShopSphere</a>
</body></html>
