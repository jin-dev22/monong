<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-주문 페이지" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/direct/direct.css" />
<h2 class="pay-title">결제 &#128179;</h2>
<div class="dProduct_selected">
	<form name="directPayFrm" method="POST" action="${pageContext.request.contextPath}/direct/directPay.do">
		<h4>선택상품</h4>
		<div class="dProduct-info">
			<div class="dProduct-info-content">
				<input type="hidden" name="dOrderNo" value=""/>
				<input type="hidden" name="dOptionNo" value=""/>
				<p class="bold">상품정보</p>
				<c:forEach items="${orderList}" var="orderList">
					<c:forEach items="${orderList.directProductOptions}" var="option">
					<c:forEach items="${orderList.directProductAttachments}" var="attach">
					<div class="dOrder-info">
						<span class="dOrder-img" style="background-image: url(${attach.DProductRenamedFilename});"></span>
						<div class="dOrder-name-container">
							<span class="dOrder-productName">${orderList.DProductName}</span>
							<input type="hidden" name="seller" value="${orderList.memberId}" />
							<span class="dOrder-optionName">[옵션] ${option.DOptionName}</span>
						</div>
						<span class="dOrder-count">${orderList.cart.productCount}개</span>
						<span class="dOrder-price"><fmt:formatNumber value="${option.DPrice * orderList.cart.productCount}" pattern="#,###" />원</span>					
					</div>
					</c:forEach>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
		<div class="dOrder-wrapper">
			<div class="dOrder-addr-info">
				<h4>배송지 정보</h4>
				<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"/>" />
				<div class="dOrder-addr-info-content">
					<label for="dRecipient">수령인</label><br/>
					<input type="text" id="dRecipient" name="dRecipient" value="<sec:authentication property="principal.memberName"/>" required /><br/>
					<span class="dRecipientCheck error">수령인을 입력해주세요.</span><br />
					<label for="dOrderPhone">연락처</label><br/>
					<input type="text" id="dOrderPhone" name="dOrderPhone" value="<sec:authentication property="principal.memberPhone"/>" required /><br/>
					<span class="dOrderPhoneCheck error">연락처는 '-'없이 숫자만 입력해주세요.</span><br />
					<label for="dDestAddress">주소</label><br/>
					<input type="text" id="dDestAddress" name="dDestAddress" value="<sec:authentication property="principal.memberAddress"/>" required readonly />
					<input type="button" id="researchButton" value="검색" class="btn btn-EA5C2B"><br/>
					<span class="dDestAddressCheck error">받으실 주소를 입력해주세요.</span><br />
					<label for="dDestAddressEx">상세주소</label><br/>
					<input type="text" id="dDestAddressEx" name="dDestAddressEx" value="<sec:authentication property="principal.memberAddressEx"/>" required /><br/>
					<label for="dDeliveryRequest">배송 요청사항(선택)</label><br/>
					<input type="text" id="dDeliveryRequest" name="dDeliveryRequest" value="">
				</div>
			</div>
			<div class="dPay-info">
				<h4>결제 정보</h4>
				<div class="dPay-info-content">
					<p>상품금액</p>
					<input type="text" name="dProductPrice" value="" readonly/>
					<p>배송비</p>
					<c:set var="dDeliveryFee" value="" />
					<input type="text" name="dDeliveryFee" value="" readonly/>
					<hr>
					<p>합계</p>
					<fmt:parseNumber value="${dDeliveryFee}" var="deliveryFee"/>
					<fmt:parseNumber value="${dProductPrice}" var="productPrice"/>
					<c:set var="dPrice" value="${dProductPrice +  dDeliveryFee}"/>
					<input type="text" name="dPrice" value="<fmt:formatNumber value="${dPrice}" type="number" pattern="#,###원" />" readonly/>
				</div>
				<div id="dOrder-card">
					<p>결제 수단</p>
					<div class="dCard">
						<input type="radio" name="s-card" id="s-card" checked>
						<label for="s-card">
							<img src="${pageContext.request.contextPath}/resources/images/card.png" alt="카드 이미지" id="card"><span>카드</span>
						</label>
					</div>
				</div>
				<div class="dOrder-totle-price">
					<span>총 결제 금액</span>
					<span class="d-price"><fmt:formatNumber value="${dPrice}" type="number" pattern="#,###" /></span><span>원</span>
				</div>
				<button type="button" class="btn btn-EA5C2B btn-d-pay" id="requestPay">주문하기</button>
			</div>
		</div>
	</form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 총 금액
window.addEventListener('load', (e) => {
	const productPrice = document.querySelectorAll(".dOrder-price");
	const productTotalPrice = document.querySelector("[name=dProductPrice]");
	// const deliveryFee = 
	// const totalPrice = document.querySelector("")
	
	const price = [...productPrice].map((p) => parseInt(p.innerHTML.replace(",", ""))).reduce((total, price) => total + price);
	console.log(price);
	
	productTotalPrice.value = price.toLocaleString('ko-KR') + '원';;
});

// 주소 API
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
			document.getElementById("sAddress").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("sAddressEx").focus();
		}
	}).open();
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>