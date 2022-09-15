<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/direct.css" />
	<c:if test="${empty list}">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">조회된 게시글이 없습니다.</li>
		</ul>
		</c:if>
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="directProduct">
				<div class="card" style="width: 18rem;">
		  			<img src="" class="card-img-top" alt="...">
		  				<ul class="list-group list-group-flush">
		    				<li class="list-group-item">${directProduct.DProductName}</li>
		    				<li class="list-group-item">
		    					<fmt:formatNumber value="${directProduct.DDefaultPrice}" pattern="#,### 원" />
		    				</li>
		    				<li class="list-group-item">판매자 : ${directProduct.memberId}</li>
		  				</ul>
				</div>
			</c:forEach>
		</c:if>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>