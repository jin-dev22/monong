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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/subscribe/subscribe.css">
<c:set var="orderListSub" value="${orderList.subscription}" />
<h2 class="pay-title">모농모농 첫 구독에 성공했습니다. &#127881;</h2>
<div class="s-product_selected grid-container-s-order">
	<div class="s-orderProduct-info">
		<h4>결제상품</h4>
		<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg" alt="싱글 이미지">
		<c:if test="${orderListSub.SProductCode eq 'SP1'}">
			<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg" alt="싱글 이미지">
		</c:if>
		<c:if test="${orderListSub.SProductCode eq 'SP2'}">
			<img src="${pageContext.request.contextPath}/resources/images/subscribe/레귤러.jpg" alt="레귤러 이미지">
		</c:if>
		<c:if test="${orderListSub.SProductCode eq 'SP3'}">
			<img src="${pageContext.request.contextPath}/resources/images/subscribe/라지.jpg" alt="라지 이미지">
		</c:if>
		<div class="s-orderProduct-info-content">
			<p class="bold">결제 상품 정보</p>
			<p>주문번호</p>
			<c:set var="sOrderNo" value="${orderList.SOrderNo}" />
			<p>${fn:replace(sOrderNo, 'SO', '')}</p>
			<p>상품명</p>
			<c:forEach items="${subscriptionProduct}" var="subProduct">
				<c:if test="${subProduct.SProductCode eq orderListSub.SProductCode}">
					<p>정기구독 - ${subProduct.SProductName}</p>
				</c:if>
			</c:forEach>
			<p>제외 채소</p>
			<p>${orderListSub.SExcludeVegs}</p>
			<p>배송 주기</p>
			<p>${orderListSub.SDeliveryCycle}주</p>
			<p>다음 배송일</p>
			<p>${orderListSub.SNextDeliveryDate} (금)</p>
		</div>
	</div>
	<div class="s-order-addr-info">
		<h4>배송지 정보</h4>
		<div class="s-order-addr-info-content grid-s-order-addr-info-content">
			<p>수령인</p>
			<p>${orderListSub.SRecipient}</p>
			<p>연락처</p>
			<p>${orderListSub.SPhone}</p>
			<p>주소</p>
			<p>${orderListSub.SAddress} ${orderListSub.SAddressEx}</p>
			<p>요청사항</p>
			<p>${orderListSub.SDeliveryRequest}</p>
		</div>
	</div>
	<div class="s-pay-info">
		<h4>결제 정보</h4>
		<div class="s-order-totle-price">
			<span>총 결제 금액</span>
			<span class="s-price"><fmt:formatNumber value="${orderList.SPrice}" type="number" pattern="#,###" /></span><span>원</span>
		</div>
		<div style="text-align: right">
			<a href="">
				<button type="button" class="btn btn-116530">구독 확인하기</button>
			</a>
			<a href="${pageContext.request.contextPath}/index.jsp">
				<button type="button" class="btn btn-116530">홈으로</button>
			</a>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>