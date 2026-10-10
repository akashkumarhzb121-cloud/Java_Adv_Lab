<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<%
    String demonstrationTitle = "Traditional JSP syntax";
    LocalDate demonstrationDate = LocalDate.now();
%>
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title><%= demonstrationTitle %></title></head>
<body><main><h1><%= demonstrationTitle %></h1>
    <p>This isolated syllabus example uses a declaration-free scriptlet and JSP expressions.</p>
    <p>Rendered on <%= demonstrationDate %>.</p>
    <p>The ShopSphere application pages themselves use JSTL and EL, not scriptlets.</p>
    <a href="<%= request.getContextPath() %>/products">Return to ShopSphere</a>
</main></body></html>
