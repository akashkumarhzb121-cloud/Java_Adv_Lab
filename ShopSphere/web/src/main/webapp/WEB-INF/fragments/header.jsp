<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.locale != null ? sessionScope.locale : 'en_IN'}"/>
<fmt:setBundle basename="com.shopsphere.messages"/>
<!doctype html>
<html lang="${sessionScope.locale != null ? sessionScope.locale : 'en'}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${pageTitle != null ? pageTitle : 'ShopSphere'}"/> · ShopSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/shopsphere.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/fragments/navbar.jsp"/>
<main class="container py-4">
    <c:if test="${not empty error}"><div class="alert alert-danger" role="alert"><c:out value="${error}"/></div></c:if>
    <c:if test="${not empty notice}"><div class="alert alert-success" role="status"><c:out value="${notice}"/></div></c:if>
