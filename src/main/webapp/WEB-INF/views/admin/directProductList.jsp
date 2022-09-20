<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/admin/adminMyPage.jsp">
	<jsp:param name="title" value="모농모농-관리자페이지"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member.css" />
<div id="prodList-container">
	<form name="directProdFilterFrm" action="${pageContext.request.contextPath}/admin/directProductList.do" method="GET">
		<select name="dSaleStatus" id="direct-saleStatus" onchange="this.form.submit()">
			<option value="판매중" ${param.dSaleStatus eq '판매중' ? 'selected' : ''}>판매중</option>
			<option value="판매중단" ${param.dSaleStatus eq '판매중단' ? 'selected' : ''}>판매중단</option>
			<option value="판매마감" ${param.dSaleStatus eq '판매마감' ? 'selected' : ''}>판매마감</option>
		</select>
	</form>
	<c:if test="${empty prodList}">	
		<div>등록된 직거래 상품이 없습니다.</div>
	</c:if>
	<c:if test="${not empty prodList}">
		<c:forEach items="${prodList}" var="prod">
			<div class="prod-container">
				<div class="prod-container-column prod-col-1">
					<img src="${pageContext.request.contextPath}/resources/upload/product/${prod.directProductAttachments[0].DProductRenamedFilename}" alt="" style="width: 100px;"/>
				</div>
				<div class="prod-container-column prod-col-2">
					<div class="prod-name">${prod.DProductName}</div>
					<div class="prod-option-container">
						<c:forEach items="${prod.directProductOptions}" var="option" varStatus="vs">
							<div>옵션 
								<c:if test="${not empty  option.DOptionName}">${vs.count} : ${option.DOptionName} - ${option.DSaleStatus}</c:if>
								<c:if test="${empty option.DOptionName}">정보 없음</c:if>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="prod-container-column prod-col-3">
					<div class="prod-regDate">등록일자 : 
						<fmt:parseDate value="${prod.DProductCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
						<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
					</div>
					<div class="prod-no">상품번호 : ${prod.DProductNo}</div>
				</div>
			</div>
		</c:forEach>
		<nav>
			${pagebar}
		</nav>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>