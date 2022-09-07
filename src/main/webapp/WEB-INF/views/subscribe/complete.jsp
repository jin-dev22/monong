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
<h2 class="pay-title">결제성공 &#128179;</h2>
<div class="s-product_selected">
		<h4>선택상품</h4>
		<div class="s-product-info">
			<!-- 이미지 수정해야함 -->
			<img src="${pageContext.request.contextPath}/resources/images/subscribe/single.jpg" alt="선택한 구독상품 이미지">
			<div class="s-product-info-content">
				<input type="hidden" name="sProductCode" value="${subscription.sProductCode}"/>
				<p class="bold">상품정보</p>
				<p>상품명</p>
				<input type="text" name="sProductName" value="상품명명 ${subscription.sProductName}" readonly/>
				<p>상품가격</p>
				<input type="text" value="상품가격격 ${subscription.sProductPrice}" readonly/>
				<p>제외 채소/과일</p>
				<input type="text" name="sExcludeVegs" value="제외 채소과일 ${subscription.sExcludeVegs}" readonly/>
				<p>배송 주기</p>
				<input type="text" name="sDeliveryCycle" value="배송 주기기기 ${subscription.sDeliveryCycle}" readonly/>
				<p>배송일</p>
				<input type="text" name="sNextDeliveryDate" value="배송일일 토일월화인경우-이번주금요일" readonly/>
			</div>
		</div>
		<div class="s-order-wrapper">
			<div class="s-order-addr-info">
				<h4>배송지 정보</h4>
				<input type="hidden" name="memberId" value="${memberId}" />
				<div class="s-order-addr-info-content">
					<label for="sRecipient">수령인</label><br/>
					<input type="text" id="sRecipient" name="sRecipient" value="회원아이디 ${subscription.memberId}" required /><br/>
					<label for="sPhone">연락처</label><br/>
					<input type="text" id="sPhone" name="sPhone" value="핸드포온${subscription.sPhone}" required /><br/>
					<label for="sAddress">주소</label><br/>
					<input type="text" id="sAddress" name="sAddress" value="주소오오 ${subscription.sAddress}" required readonly />
					<input type="button" id="researchButton" value="검색" class="btn btn-EA5C2B"><br/>
					<label for="sDeliveryRequest">배송 요청사항</label><br/>
					<input type="text" id="sDeliveryRequest" name="sDeliveryRequest" value="">
				</div>
			</div>
			<div class="s-pay-info">
				<h4>결제 정보</h4>
				<div class="s-pay-info-content">
					<p>상품금액</p>
					<input type="text" name="sProductPrice" value="상품가격격 ${subscription.sProductPrice}" readonly/>
					<p>배송비</p>
					<input type="text" name="SDELIVERYFEE" value="3천원 ${subscription.SDELIVERYFEE}" readonly/>
					<hr>
				</div>
				<div class="s-order-totle-price">
					<span>총 결제 금액</span>
					<!-- 전달받은 ${subscription.sDeliveryCycle} -->
					<span class="s-cycle">0주</span>
					<span class="s-price">위에 합계 값</span><span>원</span>
				</div>
			</div>
		</div>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>