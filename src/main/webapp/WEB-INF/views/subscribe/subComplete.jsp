<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/subscribe/subscribe.css">
<h2 class="pay-title">모농모농 첫 구독에 성공했습니다. &#127881;</h2>
<div class="s-product_selected grid-container-s-order">
	<div class="s-orderProduct-info">
		<h4>결제상품</h4>
		<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg" alt="싱글 이미지">
		<c:if test="${subscriptionList.SProductCode eq 'SP1'}">
			<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg" alt="싱글 이미지">
		</c:if>
		<c:if test="${subscriptionList.SProductCode eq 'SP2'}">
			<img src="${pageContext.request.contextPath}/resources/images/subscribe/레귤러.jpg" alt="레귤러 이미지">
		</c:if>
		<c:if test="${subscriptionList.SProductCode eq 'SP3'}">
			<img src="${pageContext.request.contextPath}/resources/images/subscribe/라지.jpg" alt="라지 이미지">
		</c:if>
		<div class="s-orderProduct-info-content">
			<p class="bold">결제 상품 정보</p>
			<p>구독번호</p>
			<p>${subscriptionList.SNo}</p>
			<p>상품명</p>
			<c:forEach items="${subscriptionProduct}" var="subProduct">
				<c:if test="${subProduct.SProductCode eq subscriptionList.SProductCode}">
					<p>정기구독 - ${subProduct.SProductName}</p>
				</c:if>
			</c:forEach>
			<p>제외 채소</p>
			<p>${subscriptionList.SExcludeVegs}</p>
			<p>배송 주기</p>
			<p>${subscriptionList.SDeliveryCycle}주</p>
			<p>결제일</p>
			<p>${subscriptionList.SPaymentDate} (수)</p>
			<p>첫 배송일</p>
			<p>${subscriptionList.SNextDeliveryDate} (금)</p>
		</div>
	</div>
	<div class="s-order-addr-info">
		<h4>배송지 정보</h4>
		<div class="s-order-addr-info-content grid-s-order-addr-info-content">
			<p>수령인</p>
			<p>${subscriptionList.SRecipient}</p>
			<p>연락처</p>
			<p>${subscriptionList.SPhone}</p>
			<p>주소</p>
			<p>${subscriptionList.SAddress} ${subscriptionList.SAddressEx}</p>
			<p>요청사항</p>
			<p>${subscriptionList.SDeliveryRequest}</p>
		</div>
	</div>
	<div class="s-pay-info">
		<h4>결제 정보</h4>
		<div class="s-order-totle-price">
			<span>총 결제 금액</span>
			<c:forEach items="${subscriptionProduct}" var="subProduct">
				<c:if test="${subProduct.SProductCode eq subscriptionList.SProductCode}">
					<c:set var="price" value="${subProduct.SProductPrice}" />
					<c:set var="deliveryFee" value="${subProduct.SDeliveryFee}" />
					<span class="s-price"><fmt:formatNumber value="${price + deliveryFee}" type="number" pattern="#,###" /></span>
					<span>원</span>
				</c:if>
			</c:forEach>
		</div>
		<div class="moveButton">
			<a href="${pageContext.request.contextPath}/member/memberSubscribeList.do">
				<button type="button" class="btn btn-116530">구독 확인하기</button>
			</a>
			<a href="${pageContext.request.contextPath}/index.jsp">
				<button type="button" class="btn btn-116530">홈으로</button>
			</a>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>