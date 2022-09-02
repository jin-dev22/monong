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

<h2 class="pay-title">결제 &#128179;</h2>
<div class="s-product_selected">
	<h4>선택상품</h4>
	<div class="s-product-info">
		<!-- 이미지 수정해야함 -->
		<img src="${pageContext.request.contextPath}/resources/images/subscribe/single.jpg" alt="선택한 구독상품 이미지">
		<div class="s-product-info-content">
			<p class="bold">상품정보</p>
			<p>상품명</p>
			<p>subscription_product - s_product_name</p>
			<p>상품가격</p>
			<p>subscription_product - s_product_price</p>
			<p>제외 채소/과일</p>
			<p>subscription - s_exclude_vegs</p>
			<p>배송 주기</p>
			<p>subscription - s_delivery_cycle</p>
			<p>배송일</p>
			<p>subscription - s_next_delivery_date</p>
		</div>
	</div>
	
	<form name="subscribeOrderFrm" action="" method="POST">
		<div class="s-order-wrapper">
			<div class="s-order-addr-info">
				<h4>배송지 정보</h4>
				<div class="s-order-addr-info-content">
					<label for="s_recipient">수령인</label><br/>
					<input type="text" id="s_recipient" name="s_recipient" value="member 이름" required /><br/>
					<label for="s_phone">연락처</label><br/>
					<input type="text" id="s_phone" name="s_phone" value="member 핸드폰" required /><br/>
					<label for="s_address">주소</label><br/>
					<input type="text" id="s_address" name="s_address" value="member 주소" required />
					<input type="button" id="researchButton" value="검색" class="btn btn-EA5C2B"><br/>
					<label for="s_address_ex">상세주소</label><br/>
					<input type="text" id="s_address_ex" name="s_address_ex" value="member 상세주소" required /><br/>
					<label for="s_delivery_request">배송 요청사항(선택)</label><br/>
					<input type="text" id="s_delivery_request" name="s_delivery_request" value="">
				</div>
			</div>
	
			<div class="s-pay-info">
				<h4>결제 정보</h4>
				<div class="s-pay-info-content">
					<p>상품금액</p>
					<p>subscription_product - s_product_price</p>
					<p>배송비</p>
					<p>subscription_product - s_delivery_fee</p>
					<hr>
					<p>합계</p>
					<p>위에 합계 값</p>
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
					<span>총 결제 금액</span>
					<!-- 전달받은 s_delivery_cycle -->
					<span class="s-times">0주</span>
					<span class="s-price">18,000</span><span>원</span>
				</div>
				<button type="button" class="btn btn-EA5C2B btn-s-pay" onclick="sOrderpay()">구독 완료하기</button>
			</div>
		</div>
	</form>
</div>
<form action="" name="">
	<input type="hidden" name="memberId" value="" />
	<input type="hidden" name="sProductCode" value="" />
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
document.querySelector("#researchButton").addEventListener('click', function(){
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			// 주소 정보를 해당 필드에 넣는다.
			document.getElementById("s_address").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("s_address_ex").focus();
		}
	}).open();
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>