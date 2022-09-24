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
<style>
div.container{
display: flex;
flex-wrap: wrap;
}
.directproductlist-wrapper {
width: 200px;
margin: 50px 20px;
}
</style>
<h1 class="d-list" style="padding-bottom: 10px;color: #EA5C2B;border-bottom: 1px solid #EA5C2B;">농산물 직거래 장터</h1>
<div class="d-flex flex-wrap justify-content-between">
	<div class="align">
		<select class="form-select" aria-label="Default select example" onchange="if(this.value) location.href=(this.value);">
			<option value="${pageContext.request.contextPath}/direct/directProductList.do">정렬기준</option>
			<option value="${pageContext.request.contextPath}/direct/orderByCreatedAt.do">최근 등록순</option>
			<option value="${pageContext.request.contextPath}/direct/orderByPriceDesc.do" selected>가격 높은순</option>
			<option value="${pageContext.request.contextPath}/direct/orderByPriceAsc.do">가격 낮은순</option>
		</select>
	</div>
</div>
<sec:authorize access="hasRole('ROLE_SELLER')">
<div class="d-flex flex-wrap justify-content-between">
		<div class="productEnroll">
			<input type="button" class="btn btn-EA5C2B float-right" onclick="location.href='directProductEnroll.do' "value="상품 등록" style="display: block; width: 220px; padding: 15px; margin: 40px auto;">
		</div>
</div>
</sec:authorize>
<c:if test="${empty list}">
	<ul class="list-group list-group-flush">
		<li class="list-group-item">조회된 상품이 없습니다.</li>
	</ul>
</c:if>
<c:if test="${not empty list}">
	<div class="container">
	<c:forEach items="${list}" var="directProduct">
			<div class="directproductlist-wrapper row justify-content-center align-items-stretch">
				<div class="card">
					<img src="${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[0].DProductRenamedFilename}" class="card-img-top">
					<div class="card-body">
						<a href = "${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${directProduct.DProductNo}" class="text-decoration-none">
				  			${directProduct.DProductName}
				  		</a>
				  		<p class="card-text"><fmt:formatNumber value="${directProduct.DDefaultPrice}" pattern="#,### 원" /></p>
				  		<p>판매자 : ${directProduct.memberId}</p>
				  	</div>
				</div>
			</div>
	</c:forEach>
	</div>
</c:if>
<nav>
	${pagebar}
</nav>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>