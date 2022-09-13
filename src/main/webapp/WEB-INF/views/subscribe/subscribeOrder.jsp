<%@page import="com.kh.monong.subscribe.model.dto.Vegetables"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
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
<!-- 아임포트 라이브러리 -->
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<!-- 다음 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 해당 페이지 js 연결 -->
<script defer src="${pageContext.request.contextPath}/resources/js/subscribeOrder.js"></script>
<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
</c:if>

<h2 class="pay-title">결제 &#128179;</h2>
<div class="s-product_selected">
	<form name="subscribeOrderFrm" method="POST" class="grid-container" action="${pageContext.request.contextPath}/subscribe/subComplete.do">
		<div class="s-product-info">
			<h4>선택상품</h4>
			<c:if test="${orderProduct.SProductCode eq 'SP1'}">
				<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg" alt="싱글 이미지">
			</c:if>
			<c:if test="${orderProduct.SProductCode eq 'SP2'}">
				<img src="${pageContext.request.contextPath}/resources/images/subscribe/레귤러.jpg" alt="레귤러 이미지">
			</c:if>
			<c:if test="${orderProduct.SProductCode eq 'SP3'}">
				<img src="${pageContext.request.contextPath}/resources/images/subscribe/라지.jpg" alt="라지 이미지">
			</c:if>
			<div class="s-product-info-content">
				<input type="hidden" name="sNo" value=""/>
				<input type="hidden" name="sOrderNo" value=""/>
				<input type="hidden" name="sProductCode" value="${orderProduct.SProductCode}"/>
				<p class="bold">상품정보</p>
				<p>상품명</p>
				<input type="text" name="sProductName" value="${orderProduct.SProductName}" readonly/>
				<p>상품가격</p>
				<div>
					<c:set var="sProductPrice" value="${orderProduct.SProductPrice}" />
					<input type="text" value="<fmt:formatNumber value="${sProductPrice}" type="number" pattern="#,###" />" readonly/>
					<span>원</span>
				</div>
				<p>제외 채소</p>
				<c:set var="excludeVegs" value="" />
				<c:forEach items="${sExcludeVegs}" var="veg" varStatus="vs">
					<c:if test="${veg ne '없음'}">
						<c:set var="excludeVegs" value="${excludeVegs}${veg}${not vs.last ? ', ' : ''}" />
					</c:if>
				</c:forEach>
				<input type="text" name="sExcludeVegs" value="${excludeVegs}" readonly/>
				<p>배송 주기</p>
				<div>
					<input type="text" name="sDeliveryCycle" value="${sDeliveryCycle}" readonly/>
					<span>주</span>
				</div>
				<p>배송일</p>
				<div>
					<input type="text" name="sNextDeliveryDate" value="" readonly/>
					<span>(금)</span>
				</div>
			</div>
		</div>
		<div class="s-order-addr-info">
			<h4>배송지 정보</h4>
			<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"/>" />
			<div class="s-order-addr-info-content">
				<label for="sRecipient">수령인</label><br/>
				<input type="text" id="sRecipient" name="sRecipient" value="<sec:authentication property="principal.memberName"/>" required /><br/>
				<span class="sRecipientCheck error">수령인을 입력해주세요.</span><br />
				<label for="sPhone">연락처</label><br/>
				<input type="text" id="sPhone" name="sPhone" value="<sec:authentication property="principal.memberPhone"/>" required /><br/>
				<span class="sPhoneCheck error">연락처는 '-'없이 숫자만 입력해주세요.</span><br />
				<label for="sAddress">주소</label><br/>
				<input type="text" id="sAddress" name="sAddress" value="<sec:authentication property="principal.memberAddress"/>" required readonly />
				<input type="button" id="researchButton" value="검색" class="btn btn-EA5C2B"><br/>
				<span class="sAddressCheck error">받으실 주소를 입력해주세요.</span><br />
				<label for="sAddressEx">상세주소</label><br/>
				<input type="text" id="sAddressEx" name="sAddressEx" value="<sec:authentication property="principal.memberAddressEx"/>" required /><br/>
				<label for="sDeliveryRequest">배송 요청사항(선택)</label><br/>
				<input type="text" id="sDeliveryRequest" name="sDeliveryRequest" value="">
			</div>
		</div>
		<div class="s-pay-info">
			<h4>결제 정보</h4>
			<div class="s-pay-info-content">
				<p>상품금액</p>
				<div>
					<input type="text" name="sProductPrice" value="<fmt:formatNumber value="${sProductPrice}" type="number" pattern="#,###" />" readonly/>
					<span>원</span>
				</div>
				<p>배송비</p>
				<c:set var="sDeliveryFee" value="${orderProduct.SDeliveryFee}" />
				<input type="text" name="sDeliveryFee" value="<fmt:formatNumber value="${sDeliveryFee}" type="number" pattern="#,### 원" />" readonly/>
				<p>합계</p>
				<fmt:parseNumber value="${sDeliveryFee}" var="deliveryFee"/>
				<fmt:parseNumber value="${sProductPrice}" var="productPrice"/>
				<c:set var="sPrice" value="${productPrice +  sDeliveryFee}"/>
				<input type="text" name="sPrice" value="<fmt:formatNumber value="${sPrice}" type="number" pattern="#,### 원" />" readonly/>
			</div>
			<div id="s-order-card">
				<input type="hidden" name="customerUid" value="" />
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
				<span class="s-cycle">${sDeliveryCycle}주</span>
				<span class="s-price"><fmt:formatNumber value="${sPrice}" type="number" pattern="#,###" /></span><span>원</span>
			</div>
			<div class="privacyAgree">
				<p>주문 내용을 확인하였으며, 정보 제공 등에 동의합니다.</p>
				<input type="checkbox" name="privacyAgree" id="privacyAgree" />
				<label for="privacyAgree">개인정보 제공 동의 : 모농모농</label><br />
				<textarea name="" id="" cols="50" rows="5">
필수 개인정보 제공 동의(판매자)
모농모농 회원 계정으로 모농모농에서 제공하는 상품 및 서비스를 구매하고자 할 경우, 모농모농은 거래 당사자간 원활한 의사소통 및 배송, 상담 등 거래이행을 위하여 필요한 최소한의 개인정보를 아래와 같이 제공하고 있습니다.

1. 개인정보를 제공받는 자 : 상품 및 서비스 판매자
2. 제공하는 개인정보 항목 : 이름, 모농모농 아이디, (휴대)전화번호, 상품 구매정보,결제수단, 상품 수령인 정보(배송상품:수령인명, 주소, (휴대)전화번호/ E쿠폰:이름, 모농모농 아이디, 휴대전화번호)
3. 개인정보를 제공받는 자의 이용목적 : 판매자와 구매자의 원활한 거래 진행, 본인의사의 확인, 고객상담 및 불만처리/부정이용 방지 등의 고객관리, 물품배송, 새로운 상품/서비스 정보와 고지사항의 안내, 상품/서비스 구매에 따른 혜택 제공
4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 개인정보 이용목적 달성 시까지 보존합니다. 단, 관계 법령의 규정에 의하여 일정 기간 보존이 필요한 경우에는 해당 기간만큼 보관 후 삭제합니다.
위 개인정보 제공 동의를 거부할 권리가 있으나, 거부 시 모농모농을 이용한 상품 및 디지털 콘텐츠 구매가 불가능합니다. 그 밖의 내용은 모농모농 자체 이용약관 및 개인정보처리방침에 따릅니다.</textarea>
			</div>
			<button type="button" class="btn btn-EA5C2B btn-s-pay" id="showkModal" data-toggle="modal" data-target="#checkModal">구독 완료하기</button>
		</div>
		<input type="hidden" class="csrfname" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
</div>
<!-- Modal -->
<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="checkModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="checkModalCenterTitle">구독 안내사항</h5>
				<button type="button" class="close closeModalBtn" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			구독 진행 시 선택하신 주기에 맞춰 [수요일]에 자동으로 결제가 됩니다.<br />
			구독 취소 및 배송미루기는 마이페이지에서 가능하며,<br />수요일 결제 이후 구독 취소 및 배송미루기 시에는 그 다음주부터 적용이 됩니다. 
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeModalBtn" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-EA5C2B" id="requestPay" >구독하기</button>
			</div>
		</div>
	</div>
</div>
<script>
window.addEventListener('load', () => {
	const today = new Date();
	deliveryDate(today);
});
// 다음배송일
const deliveryDate = function(today){
	const deliveryDate = document.querySelector("[name=sNextDeliveryDate]");
	const THURSDAY_NUM = 4; // 수요일 결제이므로, 목요일부터는 다음주 금요일날 발송
	const todayDay = today.getDay();
	
	let yy = today.getFullYear().toString();
	let month = today.getMonth() + 1;
	month = month < 10 && '0' + month;
	let date = today.getDate();
	if(todayDay < THURSDAY_NUM){ // 0 1 2 3 일 월 화 수 -> 금주 금요일
		switch(todayDay){
		case 0 : date = today.getDate() + 5; break;
		case 1 : date = today.getDate() + 4; break;
		case 2 : date = today.getDate() + 3; break;
		case 3 : date = today.getDate() + 2; break;
		}
	}
	if(todayDay >= THURSDAY_NUM){ // 4 5 6 목 금 토 -> 다음주 금요일
		switch(todayDay){
		case 4 : date = today.getDate() + 8; break;
		case 5 : date = today.getDate() + 7; break;
		case 6 : date = today.getDate() + 6; break;
		}
	}
	date = date < 10 ? '0' + date : date;
	deliveryDate.value = yy + "-" + month + "-" + date;
};

// 제공 동의 여부 확인
const privacyChk = document.querySelector("#privacyAgree");
privacyChk.addEventListener('click', () => {
	if(!privacyChk.checked){
		privacyChk.nextElementSibling.style.color = 'red';
	} else {
		privacyChk.nextElementSibling.style.color = 'inherit';
	}
});

//modal
document.querySelector("#showkModal").addEventListener('click', () => {
	// 제공 동의 여부 확인
	if(!privacyChk.checked){
	    privacyChk.nextElementSibling.style.color = 'red';
	    return;
	}
	$('#checkModal').modal('show');
	$('.closeModalBtn').on('click', () => $('#checkModal').modal('hide'));
	 
	// 주문번호 및 고객고유번호 insert
	document.querySelector("#requestPay").addEventListener('click', function requestPay(){
		const frm = document.subscribeOrderFrm;
		let merchantUid = sOrderNoMaker(); // 상점에서 관리하는 주문 번호로 정기결제 사용(중복x)
		let sNo = sNoMaker(); // 구독번호, 고유번호로 변경x
		
		let productName = '정기구독 ' + frm.sProductName.value;
		let amount = frm.sPrice.value.replace(/[^0-9]/g, "");
		let customerUid = frm.memberId.value + randomMaker(5);
		let memberName = frm.sRecipient.value;
		let memberTel = frm.sPhone.value;
		let sPrice = frm.sPrice.value.replace(/[^0-9]/g, "");
		
		let csrfName = $('.csrfname').attr('name'); // CSRF Token name
		let csrfHash = $('.csrfname').val(); // CSRF hash
		
	    var IMP = window.IMP; // 생략 가능
	    IMP.init("imp46723363");
	    
		IMP.request_pay({
			pg: 'html5_inicis.INIBillTst', // KG이니시스
			pay_method: "card",
			name : productName, // 상품명
			amount : 0, // 빌링키 발급을 위한 0
			customer_uid : customerUid, // 필수 입력 // 회원아이디+sub + 랜덤숫자
			buyer_name : memberName, // 회원이름
			buyer_tel : memberTel // 회원 전화번호
		},
		function(rsp) {
			console.log('rsp = ', rsp); // 화인용
			if (rsp.success) {
				let cardNo = rsp.card_number;
				customerUid = rsp.customer_uid;
				console.log('cardNo = ', cardNo); // 화인용
				console.log('customerUid = ', customerUid); // 화인용
	 			$.ajax({
					url: `${pageContext.request.contextPath}/subscribe/insertCardInfo.do`,
					method: "POST",
					data: {
						cardNo,
						customerUid,
						amount,
						memberName,
						merchantUid,
						[csrfName]: csrfHash // csrf값 전달
					},
					success(response){
	//					console.log('response : ', response);
						frm.sNo.value = sNo;
						frm.sOrderNo.value = merchantUid;
						frm.customerUid.value = customerUid;
						frm.sPrice.value = sPrice;
						frm.sDeliveryRequest.value = frm.sDeliveryRequest.value;
						frm.submit();
					},
					error(){
						console.log();	
					}
				});
			} else {
				alert('결제에 실패했습니다. 다시 시도해주세요');
				console.log("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
			}
		});
	});
});

function todayFormat(){
	const today = new Date();
	let month = today.getMonth() + 1;
	let day = today.getDate();
	
	month = month >= 10 ? month : '0' + month;
	day = day >= 10 ? day : '0' + day;
	
	return today.getFullYear() + month + day;
};

//주문번호 SO2209011201 + 랜덤3자리 = 총 15자리(매변 변경되고 매번 전달되어야함)
function sOrderNoMaker(){
	let merchantUid = '';
	let random = randomMaker(3);
	
	let today = todayFormat();
	let hh = new Date().getHours();
	let mm = new Date().getMinutes();
	let time = hh + mm;
	
	merchantUid = 'SO' + today + time + random;
	return merchantUid;
};

// 구독번호 S + 220902 + 12345 12자리
function sNoMaker(){
	let today = todayFormat();
	sNo = "S" + today + randomMaker(5);
	
	return sNo;
};

function randomMaker(len){
	let random = '';
	for(i = 0; i < len; i++){
		random += Math.floor(Math.random() * 10);
	}
	return random;
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>