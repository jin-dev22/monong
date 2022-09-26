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
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/direct/direct.css" />
<style>
div.container{
display: flex;
flex-wrap: wrap;
}
.directproductlist-wrapper {
width: 270px;
margin: 30px 17px;
}

.direct-card-img-top{
height: 240px;
width: 240px;
border-radius: 5px;
}

.text-decoration-none{
font-size : 21px;
font-weight : 900
}
</style>
<h1 class="d-list" style="padding-bottom: 10px;color: #EA5C2B;border-bottom: 1px solid #EA5C2B;">농산물 직거래 장터</h1>
<div class="d-flex flex-wrap justify-content-between">
	<div class="align">
		<select class="form-select" aria-label="Default select example" onchange="if(this.value) location.href=(this.value);" style="display: block; width: 210px; padding: 8px; margin: 40px auto;">
			<option value="${pageContext.request.contextPath}/direct/directProductList.do">정렬기준</option>
			<option value="${pageContext.request.contextPath}/direct/orderByCreatedAt.do">최근 등록순</option>
			<option value="${pageContext.request.contextPath}/direct/orderByPriceDesc.do" selected>가격 높은순</option>
			<option value="${pageContext.request.contextPath}/direct/orderByPriceAsc.do">가격 낮은순</option>
		</select>
	</div>
	<sec:authorize access="hasRole('ROLE_SELLER')">
		<div class="productEnroll">
			<input type="button" class="btn btn-EA5C2B" onclick="location.href='directProductEnroll.do' "value="상품 등록" style="display: block; width: 220px; padding: 15px; margin: 40px auto;">
		</div>
	</sec:authorize>
</div>
<c:if test="${empty list}">
	<ul class="list-group list-group-flush">
		<li class="list-group-item">조회된 상품이 없습니다.</li>
	</ul>
</c:if>
<c:if test="${not empty list}">
	<div class="container">
	<c:forEach items="${list}" var="directProduct">
			<div class="directproductlist-wrapper row justify-content-center align-items-stretch">
				<div class="card bg-white" style="padding-top: 14px;">
					<a href = "${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${directProduct.DProductNo}" class="text-decoration-none" style="display: flex; justify-content: center;">
						<img src="${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[0].DProductRenamedFilename}" class="direct-card-img-top" id=direct-card-img-top>
					</a>
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