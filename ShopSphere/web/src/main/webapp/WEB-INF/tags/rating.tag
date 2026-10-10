<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ attribute name="value" required="false" type="java.lang.Double" %>
<%@ attribute name="count" required="false" type="java.lang.Integer" %>
<span class="rating" aria-label="Rating ${value} out of 5">★ <fmt:formatNumber value="${value}" maxFractionDigits="1"/> <small>(<c:out value="${count}"/>)</small></span>
