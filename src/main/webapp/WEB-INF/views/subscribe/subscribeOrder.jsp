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

<h2 class="pay-title">결제 &#128179;</h2>
<div class="s-product_selected">
	<form name="subscribeOrderFrm" method="POST" action="${pageContext.request.contextPath}/subscribe/insertSubOrder.do">
		<h4>선택상품</h4>
		<div class="s-product-info">
			<!-- 이미지 수정해야함 -->
			<img src="${pageContext.request.contextPath}/resources/images/subscribe/single.jpg" alt="선택한 구독상품 이미지">
			<div class="s-product-info-content">
				<input type="hidden" name="sNo" value=""/>
				<input type="hidden" name="sProductCode" value="${subscription.sProductCode}"/>
				<p class="bold">상품정보</p>
				<p>상품명</p>
				<input type="text" name="sProductName" value="상품명명 ${subscription.sProductName}" readonly/>
				<p>상품가격</p>
				<input type="text" value="상품가격격 ${subscription.sProductPrice}" readonly/>
				<p>제외 채소</p>
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
					<span class="sRecipientCheck error">수령인을 입력해주세요.</span><br />
					<label for="sPhone">연락처</label><br/>
					<input type="text" id="sPhone" name="sPhone" value="핸드포온${subscription.sPhone}" required /><br/>
					<span class="sPhoneCheck error">연락처는 '-'없이 숫자만 입력해주세요.</span><br />
					<label for="sAddress">주소</label><br/>
					<input type="text" id="sAddress" name="sAddress" value="주소오오 ${subscription.sAddress}" required readonly />
					<input type="button" id="researchButton" value="검색" class="btn btn-EA5C2B"><br/>
					<span class="sAddressCheck error">받으실 주소를 입력해주세요.</span><br />
					<label for="sAddressEx">상세주소</label><br/>
					<input type="text" id="sAddressEx" name="sAddressEx" value="상세주소오오 ${subscription.sAddressEx}" required /><br/>
					<label for="sDeliveryRequest">배송 요청사항(선택)</label><br/>
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
					<p>합계</p>
					<input type="text" name="sPrice" value="${subscription.sProductPrice} + ${subscription.SDELIVERYFEE}" readonly/>
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
					<!-- 전달받은 ${subscription.sDeliveryCycle} -->
					<span class="s-cycle">0주</span>
					<span class="s-price">위에 합계 값</span><span>원</span>
				</div>
				<button type="button" class="btn btn-EA5C2B btn-s-pay" onclick="requestPay()">구독 완료하기</button>
			</div>
		</div>
	</form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 주문번호 및 고객고유번호 insert
function requestPay(){
	const frm = document.subscribeOrderFrm;
	let random = '';
	const len = 5; // 랜덤 5자리
	for(i = 0; i < len; i++){
		random += Math.floor(Math.random() * 10);
	}
	const today = todayFormat();
	console.log(today);
	console.log(random);
	
	let merchantUid = "S" + today + random; // 상점에서 관리하는 주문 번호(변경되야함) // 구독번호 S + 220905 + 12345 12자리
	/* let productName = frm.sProductName.value;
	let amount = frm.sPrice.value;
	let customerUid = ${memberId} + 'sub' + random;
	let memberName = ${memberSName};
	let memberTel = ${memberSPhone}; */
	// test 용
	let productName = '정기구독 스몰';
	let amount = 1000;
	let customerUid = 'sunsub' + random;
	let memberName = '모농';
	let memberTel = '01011112222';
	
    var IMP = window.IMP; // 생략 가능
    IMP.init("imp46723363");
    
	IMP.request_pay({
		pg: 'html5_inicis.INIBillTst', // KG이니시스
		pay_method: "card",
		name : productName, // 상품명
		merchant_uid : merchantUid,
		amount : amount, // 빌링키 발급만 진행하며 결제승인을 하지 않습니다. // 실제 금액은 빌링키 발급 후 결제실행 부분에서 진행
		customer_uid : customerUid, // 필수 입력 // 회원아이디+sub + 랜덤숫자
		buyer_name : memberName, // 회원이름
		buyer_tel : memberTel // 회원 전화번호
	},
	function(rsp) {
		console.log('rsp = ', rsp); // 화인용
		if (rsp.success) {
			alert('결제 성공');
			let cardNo = rsp.card_number;
			customerUid = rsp.customer_uid;
 			$.ajax({
				url: `${pageContext.request.contextPath}/subscribe/insertCardInfo.do`,
				method: "POST",
				data: {cardNo, customerUid},
				success(response){
					console.log('insertCardInfo response: ', response);
					
					// 토큰 발급
					const getToken = ({
						url: "https://api.iamport.kr/users/getToken",
						method: "POST", // POST method
						headers: { "Content-Type": "application/json" }, // "Content-Type": "application/json"
						data: {
							imp_key: "1480425783421144", // REST API 키
							imp_secret: "s40CDRqPexBS6w9QbZd62CTK6yILrMWq5ro7WNiNq606CWMvwPev6W9Xe2YnzWre9FQtVMZQrh0LBEep" // REST API Secret
						}
					});
					
					
					// 결제(재결제) 요청
					const paymentResult11 = async(res) => {
						const paymentResult = await axios({
							url: "https://api.iamport.kr/subscribe/payments/again",
							method: "POST",
							headers: { "Authorization": access_token }, // 인증 토큰을 Authorization header에 추가
							data: {
								customerUid,
								merchantUid, // 새로 생성한 결제(재결제)용 주문 번호
								amount,
								productName
							}
						});
					};
					console.log("paymentResult11: ", paymentResult11);
					console.log("paymentResult11.res: ", paymentResult11.res);
					console.log("res: ", res);
					
					const {code, message} = response;
					console.log("code, message", code, message);
					if (code === 0) { // 카드사 통신에 성공(실제 승인 성공 여부는 추가 판단이 필요함)
						if (paymentResult.status === "paid" ) { //카드 정상 승인
							res.send({status: "success", message: "정기구독 결제 성공"});
						}
						else { //카드 승인 실패 (예: 고객 카드 한도초과, 거래정지카드, 잔액부족 등)
							//paymentResult.status : failed 로 수신됨
							res.send({status: "failed", message: "결제 실패" });
						}
					} else { // 카드사 요청에 실패 (paymentResult is null)
						res.send({status: "Cfailed", message: "카드사 요청에 의해 실패했습니다."});
					}
					frm.sNo.value = merchant_uid;
					frm.customerUid.value = customerUid;
					frm.submit();
				},
				error(){
					console.log();	
				}
			});
		} else {
			alert('빌링키 발급 실패');
			console.log("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
		}
	});
};

/* // 결제 예약
axios({
  url: \`https://api.iamport.kr/subscribe/payments/schedule\`,
  method: "POST",
  headers: { "Authorization": access_token }, // 인증 토큰 Authorization header에 추가
  data: {
    customer_uid: "gildong_0001_1234", // 카드(빌링키)와 1:1로 대응하는 값
    schedules: [
      {
        merchant_uid: "order_monthly_0001", // 주문 번호
        schedule_at: 1519862400, // 결제 시도 시각 in Unix Time Stamp. 예: 다음 달 1일
        amount: 8900,
        name: "월간 이용권 정기결제",
        buyer_name: "홍길동",
        buyer_tel: "01012345678",
        buyer_email: "gildong@gmail.com"
      }
    ]
  }
}); */



//220901 6자리 날짜포맷
function todayFormat(){
	const date = new Date();
	let yy = date.getFullYear().toString().substring(2);
	let month = date.getMonth() + 1;
	month = month < 10 && '0' + month;
	let day = date.getDate();
	day = day < 10 && '0' + day;
	let time = date.getTime();
	return yy + month + day + time;
};

//주소 유효성 검사
document.querySelector("#sAddress").addEventListener('input', (e) => {
	const sAddress = e.target;
	const error = document.querySelector(".sAddressCheck.error");
	if(!/^[\S].+$/.test(sAddress.value)){
		error.style.display = "block";
		sAddress.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		sAddress.style.borderBottom = "1px solid #116530";
	}
});
// 핸드폰번호 유효성 검사
document.querySelector("#sPhone").addEventListener('input', (e) => {
	const sPhone = e.target;
	const error = document.querySelector(".sPhoneCheck.error");
	if(!/^[0-9]{11}$/.test(sPhone.value)){
		error.style.display = "block";
		sPhone.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		sPhone.style.borderBottom = "1px solid #116530";
	}
});
// 수령인 유효성 검사
document.querySelector("#sRecipient").addEventListener('input', (e) => {
	const sRecipient = e.target;
	const error = document.querySelector(".sRecipientCheck.error");
	if(!/^[a-zA-z가-힣]+$/.test(sRecipient.value)){
		error.style.display = "block";
		sRecipient.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		sRecipient.style.borderBottom = "1px solid #116530";
	}
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