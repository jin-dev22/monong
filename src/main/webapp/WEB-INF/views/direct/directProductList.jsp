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
<h1 class="d-list" style="padding-bottom: 10px;color: #EA5C2B;border-bottom: 1px solid #EA5C2B;">농산물 직거래 장터</h1>
<div class="d-flex flex-wrap justify-content-between">
	    	<div class="align">
	       	 <form action="${ pageContext.request.contextPath }/direct/directProductAlign.do" method="get">
	             <select class="form-select" aria-label="Default select example" name="align" onchange="this.form.submit()">
				  <option value="#" selected>정렬기준</option>
				  <option value="#">최근 등록순</option>
				  <option value="#">가격 높은순</option>
				  <option value="#">가격 낮은순</option>
				  <option value="#">후기 많은순</option>
				 </select>
	         </form>
	       	</div>
</div>
<div class="d-flex flex-wrap justify-content-between">
		<div class="productEnroll">
			<input type="button" class="btn btn-EA5C2B float-right" onclick="location.href='directProductEnroll.do' "value="상품 등록" style="display: block; width: 220px; padding: 15px; margin: 40px auto;">
		</div>
</div>
	<c:if test="${empty list}">
		<ul class="list-group list-group-flush">
			<li class="list-group-item">조회된 상품이 없습니다.</li>
		</ul>
		</c:if>
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="directProduct">
<div class="container">
	<div class="row justify-content-center row-cols-3 row-cols-lg-3 align-items-stretch g-5 py-5">
		<div class="col">
			<div class="card card-cover h-100 overflow-hidden bg-warning mb-3 border-success mb-3 rounded-5 shadow-lg">
				<img src="${pageContext.request.contextPath}/resources/upload/product/${directProduct.directProductAttachments[0].DProductRenamedFilename}" class="card-img-top">
						<a href = "${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${directProduct.DProductNo}" class="text-decoration-none">
			  				<h6>${directProduct.DProductName}</h6>
			  			</a>
			  	<ul class="d-flex list-unstyled mt-auto">
			    	<li class="me-auto">
			    		<fmt:formatNumber value="${directProduct.DDefaultPrice}" pattern="#,### 원" />
			    	</li>
			    	<li class="list-group-item">판매자 : ${directProduct.memberId}</li>
			  	</ul>
			</div>
		</div>
	</div>
</div>
			</c:forEach>
		</c:if>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>