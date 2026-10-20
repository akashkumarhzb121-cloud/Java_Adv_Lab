<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<%! int viewCount = 0; %>
<%
    viewCount++;
    String demonstrationTitle = "Traditional JSP syntax";
    LocalDate demonstrationDate = LocalDate.now();
%>
<!doctype html>
<html lang="en">
<head><meta charset="utf-8"><title><%= demonstrationTitle %></title></head>
<body>
<main>
    <h1><%= demonstrationTitle %></h1>
    <%-- JSP comment: declarations, scriptlets and expressions are shown here for the syllabus. --%>
    <p>Declaration-backed hit counter for this JVM: <%= viewCount %></p>
    <p>Rendered on <%= demonstrationDate %>.</p>
    <p>The main ShopSphere pages use EL and JSTL instead of scriptlets.</p>
    <a href="<%= request.getContextPath() %>/home">Return to ShopSphere</a>
</main>
</body>
</html>
