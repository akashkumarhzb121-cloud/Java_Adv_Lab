<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ attribute name="value" required="false" type="java.lang.Double" %>
<%@ attribute name="count" required="false" type="java.lang.Integer" %>
<c:set var="val" value="${value != null ? value : 0.0}" />
<span class="rating-badge d-inline-flex align-items-center" aria-label="Rating ${val} out of 5">
    <span class="stars text-warning d-inline-flex gap-1" style="font-size: 0.85rem;">
        <c:forEach var="i" begin="1" end="5">
            <c:choose>
                <c:when test="${val ge i}">
                    <i class="bi bi-star-fill"></i>
                </c:when>
                <c:when test="${val ge (i - 0.5)}">
                    <i class="bi bi-star-half"></i>
                </c:when>
                <c:otherwise>
                    <i class="bi bi-star text-black-50"></i>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </span>
    <strong class="rating-num ms-1 text-dark" style="font-size: 0.85rem;"><fmt:formatNumber value="${val}" minFractionDigits="1" maxFractionDigits="1"/></strong>
    <c:if test="${count != null}">
        <small class="text-muted ms-1" style="font-size: 0.78rem;">(<c:out value="${count}"/>)</small>
    </c:if>
</span>
