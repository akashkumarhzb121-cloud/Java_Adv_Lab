<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="x" uri="jakarta.tags.xml" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<x:parse var="sample">
    <syllabus><topic>JSTL XML parsing</topic><topic>Namespace-aware XML values</topic></syllabus>
</x:parse>
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>JSTL XML demo</title></head>
<body><h1><x:out select="$sample/syllabus/topic[1]"/></h1>
    <ul><x:forEach select="$sample/syllabus/topic"><li><x:out select="."/></li></x:forEach></ul>
    <a href="${pageContext.request.contextPath}/products">Return to ShopSphere</a>
</body></html>
