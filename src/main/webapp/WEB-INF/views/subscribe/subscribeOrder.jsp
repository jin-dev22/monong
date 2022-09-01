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

<h2 class="pay-title">결제 &#128179;</h2>
<div class="s-product_selected">
	<h4>선택상품</h4>
	<div class="s-product-info">
		<!-- 이미지 수정해야함 -->
		<img src="${pageContext.request.contextPath}/resources/images/subscribe/single.jpg" alt="선택한 구독상품 이미지">
		<div class="s-product-info-content">
			<p class="bold">상품정보</p>
			<p>상품명</p>
			<p>get 값</p>
			<p>상품가격</p>
			<p>get 값</p>
			<p>제외 채소/과일</p>
			<p>get 값</p>
			<p>배송 주기</p>
			<p>get 값</p>
			<p>배송일</p>
			<p>get 값</p>
			<!-- 첫 배송 시에만 20%, 첫 배송 아닐 시 - 로 보이기 -->
			<p>할인율</p>
			<p>첫 배송 20%</p>
		</div>
	</div>

	<div class="s-order-wrapper">
		<div class="s-order-addr-info">
			<h4>배송지 정보</h4>
			<div class="s-order-addr-info-content">
				<form name="subscribeOrderAddrFrm" action="" method="POST">
					<label for="s-receiver-name">수령인</label><br />
					<input type="text" id="s-receiver-name" name="s-receiver-name" required><br />
					<label for="s-receiver-tel">연락처</label><br />
					<input type="text" id="s-receiver-tel" name="s-receiver-tel" required><br />
					<label for="s-receiver-addr1">주소</label><br />
					<input type="text" id="s-receiver-addr1" name="s-receiver-addr1" required>
					<input type="button" value="검색" class="btn btn-EA5C2B"><br />
					<label for="s-receiver-addr2">상세주소</label><br />
					<input type="text" id="s-receiver-addr2" name="s-receiver-addr2" required><br />
					<label for="s-receiver-etc">배송 요청사항(선택)</label><br />
					<input type="text" id="s-receiver-etc" name="s-receiver-etc">
				</form>
			</div>
		</div>

		<div class="s-pay-info">
			<h4>결제 정보</h4>
			<div class="s-pay-info-content">
				<p>상품금액</p>
				<p>get 값</p>
				<p>배송비</p>
				<p>get 값</p>
				<hr>
				<p>합계</p>
				<p>get 값</p>
			</div>
			<div id="s-order-card">
				<p>결제 수단</p>
				<div class="s-card">
					<input type="radio" name="s-card" id="s-card" checked>
					<label for="s-card">
						<img src="${pageContext.request.contextPath}/resources/images/card.png" alt="카드 이미지" id="card"><span>카드</span>
					</label>
				</div>
			</div>
			<div class="s-order-totle-price">
				<span>총 결제 금액</span> <span class="s-times">0주</span>
				<ul>
					<!-- 첫 구독시에만 노출 -->
					<li>첫 구독 20% 할인</li>
					<li class="s-total-price">18,000 <span>원</span></li>
					<!-- 첫 구독시에만 노출 -->
					<li class="s-original-price">20,000원</li>
				</ul>
			</div>
			<!-- 나중에 submit으로 수정하기 -->
			<button type="button" class="btn btn-EA5C2B btn-s-pay">구독 완료하기</button>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>