<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/direct/direct.css" />
<h2 class="pay-title">결제 &#128179;</h2>
<div class="dProduct_selected">
	<form name="directPayFrm" method="POST" action="${pageContext.request.contextPath}/direct/directPay.do">
		<h4>선택상품</h4>
		<div class="dProduct-info">
			<div class="dProduct-info-content">
				<p class="bold">상품정보</p>
				<c:forEach items="${orderList}" var="orderList">
					<c:forEach items="${orderList.directProductOptions}" var="option">
					<div class="dOrder-info">
						<span class="dOrder-img" style="background-image: url(${pageContext.request.contextPath}/resources/upload/product/${orderList.directProductAttachments[0].DProductRenamedFilename});"></span>
						<div class="dOrder-name-container">
							<span class="dOrder-productName">${orderList.DProductName}</span>
							<input type="hidden" name="seller" value="${orderList.memberId}" />
							<span class="dOrder-optionName">[옵션] ${option.DOptionName}</span>
						</div>
						<span class="dOrder-count">${orderList.cart.productCount} 개</span>
						<input type="hidden" name="dProductNo" value="${orderList.DProductNo}"/>
						<input type="hidden" name="dOptionNo" value="${option.DOptionNo}"/>
						<input type="hidden" name="productCount" value="${orderList.cart.productCount}"/>
						<input type="hidden" name="dStock" value="${option.DStock}"/>
						<span class="dOrder-price"><fmt:formatNumber value="${option.DPrice * orderList.cart.productCount}" pattern="#,###" /> 원</span>					
					</div>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
		<div class="dOrder-wrapper">
			<div class="dOrder-addr-info">
				<sec:authentication property="principal" var="loginMember"/>
				<input type="hidden" id="memberId" name="memberId" value="${loginMember.memberId}" />
				<input type="hidden" id="memberEmail" name="memberEmail" value="${loginMember.memberEmail}" />
				<h4>배송지 정보</h4>
				<div class="dOrder-addr-info-content">
					<label for="dRecipient">수령인</label><br/>
					<input type="text" id="dRecipient" name="dRecipient" value="${loginMember.memberName}" required /><br/>
					<span class="dRecipientCheck error">수령인을 입력해주세요.</span><br />
					<label for="dOrderPhone">연락처</label><br/>
					<input type="text" id="dOrderPhone" name="dOrderPhone" value="${loginMember.memberPhone}" required /><br/>
					<span class="dOrderPhoneCheck error">연락처는 '-'없이 숫자만 입력해주세요.</span><br />
					<label for="dDestAddress">주소</label><br/>
					<input type="text" id="dDestAddress" name="dDestAddress" value="${loginMember.memberAddress}" required readonly />
					<input type="button" id="researchButton" value="검색" class="btn btn-EA5C2B"><br/>
					<span class="dDestAddressCheck error">받으실 주소를 입력해주세요.</span><br />
					<label for="dDestAddressEx">상세주소</label><br/>
					<c:if test="${loginMember.memberAddressEx eq null}">
						<input type="text" id="dDestAddressEx" name="dDestAddressEx" value="" required /><br/>
					</c:if>
					<c:if test="${loginMember.memberAddressEx ne null}">
						<input type="text" id="dDestAddressEx" name="dDestAddressEx" value="${loginMember.memberAddressEx}" required /><br/>
					</c:if>
					<label for="dDeliveryRequest">배송 요청사항(선택)</label><br/>
					<input type="text" id="dDeliveryRequest" name="dDeliveryRequest" value="">
				</div>
			</div>
			<div class="dPay-info">
				<h4>결제 정보</h4>
				<div class="dPay-info-content">
					<p>상품금액</p>
					<input type="text" name="dProductPrice" value="" readonly/><span>원</span>
					<p>배송비 <span style="font-size: 12px; color:#afb0b3;">(판매자별)</span></p>
					<input type="text" name="dDeliveryFee" value="" readonly/><span>원</span>
					<div style="border-top: 1px solid #333; margin-bottom: 8px; background-color: #333;"></div>					
					<p>합계</p>
					<input type="text" name="dPrice" value="" readonly/><span>원</span>
				</div>
				<div id="d-order-card">
					<p>결제 수단</p>
					<div class="d-card">
						<div class="payCheck">
							<label for="d-card-kg">
								<img src="${pageContext.request.contextPath}/resources/images/card.png" alt="일반결제 이미지" id="card"><span>일반결제</span>
							</label>
							<input type="radio" name="d-card" id="d-card-kg" value="kg" checked>
						</div>
						<div>
							<label for="d-card-kakao">
								<img src="${pageContext.request.contextPath}/resources/images/kakaopay.png" alt="카카오페이 이미지" id="card"><span>카카오페이</span>
							</label>
							<input type="radio" name="d-card" id="d-card-kakao" value="kakaoPay">
							<input type="hidden" name="dPayments" value="카드"/>
						</div>
					</div>
				</div>
				<div class="dOrder-totle-price">
					<span>총 결제 금액</span>
					<span class="d-price"></span><span>원</span>
					<input type="hidden" name="dTotalPrice" value="" />
				</div>
				<div class="privacyAgree">
					<input type="checkbox" id="all-privacyAgree" />
					<label for="all-privacyAgree" style="font-weight: 700;">주문 내용을 확인하였으며, 전체 동의합니다.</label><br />
					<input type="checkbox" name="privacyAgree" id="privacyAgree1" />
					<label for="privacyAgree1">개인정보 제공 동의 : 모농모농</label><button type="button" id="privacyAgree1-overview" style="font-size: 12px; font-weight: bold; -webkit-transform: scale(2,1); float: right; background-color: #fff; border: none; cursor: pointer;">∨</button><br />
					<textarea name="" id="toggle1" cols="50" rows="5" readonly>
필수 개인정보 제공 동의(판매자)
모농모농 회원 계정으로 모농모농에서 제공하는 상품 및 서비스를 구매하고자 할 경우, 모농모농은 거래 당사자간 원활한 의사소통 및 배송, 상담 등 거래이행을 위하여 필요한 최소한의 개인정보를 아래와 같이 제공하고 있습니다.

1. 개인정보를 제공받는 자 : 상품 및 서비스 판매자
2. 제공하는 개인정보 항목 : 이름, 모농모농 아이디, (휴대)전화번호, 상품 구매정보,결제수단, 상품 수령인 정보(배송상품:수령인명, 주소, (휴대)전화번호/ E쿠폰:이름, 모농모농 아이디, 휴대전화번호)
3. 개인정보를 제공받는 자의 이용목적 : 판매자와 구매자의 원활한 거래 진행, 본인의사의 확인, 고객상담 및 불만처리/부정이용 방지 등의 고객관리, 물품배송, 새로운 상품/서비스 정보와 고지사항의 안내, 상품/서비스 구매에 따른 혜택 제공
4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 개인정보 이용목적 달성 시까지 보존합니다. 단, 관계 법령의 규정에 의하여 일정 기간 보존이 필요한 경우에는 해당 기간만큼 보관 후 삭제합니다.
위 개인정보 제공 동의를 거부할 권리가 있으나, 거부 시 모농모농을 이용한 상품 및 디지털 콘텐츠 구매가 불가능합니다. 그 밖의 내용은 모농모농 자체 이용약관 및 개인정보처리방침에 따릅니다.</textarea>
					<input type="checkbox" name="privacyAgree" id="privacyAgree2" />
					<label for="privacyAgree2">결제대행서비스 약관 동의</label><button type="button" id="privacyAgree2-overview" style="font-size: 12px; font-weight: bold; -webkit-transform: scale(2,1); float: right; background-color: #fff; border: none; cursor: pointer;">∨</button><br />
					<div class="toggle2" style="display: none;">
					&nbsp;&lt;전자금융거래 이용약관&gt;
					<textarea name="" class="toggle2" cols="50" rows="5" readonly>
제1조 (목적)
이 약관은 주식회사 케이지이니시스(이하 ‘회사’라 합니다)가 제공하는 전자지급결제대행서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다.

제2조 (용어의 정의)
이 약관에서 정하는 용어의 정의는 다음과 같습니다.  1. ‘전자금융거래’라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스 (이하 ‘전자금융거래 서비스’라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소 통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.
2. ‘전자지급수단’이라 함은 전자자금이체, 직불전자지급수단, 선불전자지급수단, 전자화폐, 신용카드, 전자채 권 그 밖에 전자적 방법에 따른 지급 수단을 말합니다.
3. ‘전자지급결제대행서비스’라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보 를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.
4. ‘결제대금예치서비스’라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 ‘결제대금’이 라 한다)의 전부 또는 일부를 재화 또는 용역(이하 ‘재화 등’이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인시점까지 결제대금을 예치하는 서비스를 말합니다.
5. ‘이용자’라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.
6. ‘접근매체’라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), ‘전자서명법’상의 인증서, 회사에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보 를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.
7. ‘거래지시’라 함은 이용자가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 회사에 대하여 전자금 융거래의 처리를 지시하는 것을 말합니다.
8. ‘오류’라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시 에 따라 이행되지 아니한 경우를 말합니다.
9. ‘정보통신망’이라 함은 전기통신설비를 이용하거나 전기통신설비와 컴퓨터 및 컴퓨터의 이용기술을 활용 하여 정보를 수집∙가공∙검색∙송신 또는 수신하는 정보통신체제를 말합니다.
본 조 및 본 약관의 다른 조항에서 정의한 것을 제외하고는 전자금융거래법 등 관계 법령에 따릅니다.

제3조 (약관의 명시 및 변경)
1. 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.
2. 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.
3. 회사가 약관을 변경하는 때에는 그 시행일 1개월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.

제4조 (전자지급결제 대행서비스의 종류)
회사가 제공하는 전자지급결제대행서비스는 지급결제수단에 따라 다음과 같이 구별됩니다
1. 신용카드결제대행서비스 : 이용자가 결제대금의 지급을 위하여 제공한 지급결제수단이 신용카드인 경우 로서, 회사가 전자결제시스템을 통하여 신용카드 지불정보를 송,수신하고 결제대금의 정산을 대행하거나 매개하는 서비스를 말합니다.
2. 계좌이체대행서비스 : 이용자가 결제대금을 회사의 전자결제시스템을 통하여 금융기관에 등록 정산을 대행하거나 매개하는 서비스를 말합니다. 한 자신의 계좌에서 출금하여 원하는 계좌로 이체할 수 있는 실시간 송금 서비스를 말합니다.
3. 가상계좌서비스 : 이용자가 결제대금을 현금으로 결제하고자 경우 회사의 전자결제시스템을 통하여 자동 으로 이용자만의 고유한 일회용 계좌의 발급을 통하여 결제대금의 지급이 이루어지는 서비스를 말합니다.
4. 기타 : 회사가 제공하는 서비스로서 지급결제수단의 종류에 따라 ‘휴대폰 결제대행서비스’, ‘ARS결제대행 서비스’, ‘상품권결제대행서비스’등이 있습니다.

제5조 (결제대금예치 서비스의 내용)
1. 이용자(이용자의 동의가 있는 경우에는 재화 등을 공급받을 자를 포함합니다. 이하 본 조에서 같습니다)는 재화 등을 공급받은 사실을 재화 등을 공급받은 날부터 3영업일 이내에 회사에 통보하여야 합니다.
2. 회사는 이용자로부터 재화 등을 공급받은 사실을 통보받은 후 회사와 통신판매업자간 사이에서 정한 기일 내에 통신판매업자에게 결제대금을 지급합니다.
3. 회사는 이용자가 재화 등을 공급받은 날부터 3영업일이 지나도록 정당한 사유의 제시없이 그 공급 받은 사실을 회사에 통보하지 아니하는 경우에는 이용자의 동의없이 통신판매업자에게 결제대금을 지급할 수 있습니다.
4. 회사는 통신판매업자에게 결제대금을 지급하기 전에 이용자에게 결제대금을 환급받을 사유가 발생한 경우에는 그 결제대금을 소비자에게 환급합니다.
5. 회사는 이용자와의 결제대금예치서비스 이용과 관련된 구체적인 권리,의무를 정하기 위하여 본 약관과는 별도로 결제대금예치서비스이용약관을 제정할 수 있습니다.

제6조 (이용시간)
1. 회사는 이용자에게 연중무휴 1일 24시간 전자금융거래 서비스를 제공함을 원칙으로 합니다.
단, 금융기관 기타 결제수단 발행업자의 사정에 따라 달리 정할 수 있습니다.
2. 회사는 정보통신설비의 보수, 점검 기타 기술상의 필요나 금융기관 기타 결제수단 발행업자의 사정에 의하여 서비스 중단이 불가피한 경우, 서비스 중단 3일 전까지 게시가능한 전자적 수단을 통하여 서비스 중단 사실을 게시한 후 서비스를 일시 중단할 수 있습니다.
다만, 시스템 장애복구, 긴급한 프로그램 보수, 외부요인 등 불가피한 경우에는 사전 게시없이 서비스를 중단할 수 있습니다

제7조
(접근매체의 선정과 사용 및 관리)
1. 회사는 전자금융거래 서비스 제공 시 접근매체를 선정하여 이용자의 신원, 권한 및 거래지시의 내용 등을 확인할 수 있습니다. 해당정보를 이용하지 않으며, 기 요구 시에는 즉각 폐기하여 어떠한 용도로도 사용할 수 없도록 합니다.
2. 이용자는 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공 할 수 없습니다.
3. 이용자는 자신의 접근매체를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며, 접근매체의 도용이 나 위조 또는 변조를 방지하기 위하여 충분한 주의를 기울여야 합니다.
회사는 이용자로부터 접근매체의 분실이나 도난 등의 통지를 받은 때에는 그 때부터 제3자가 그 접근 매 체를 사용함으로 인하여 이용자에게 발생한 손해를 배상할 책임이 있습니다. 유출에 주의하여 주시기 바랍니다.

제8조 (거래내용의 확인)
1. 회사는 이용자와 미리 약정한 전자적 방법을 통하여 이용자의 거래내용(이용자의 ‘오류정정 요구 사실 및 처리결과에 관한 사항’을 포함합니다)을 확인할 수 있도록 하며, 이용자의 요청이 있는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송 등의 방법으로 거래내용에 관한 서면을 교부합니다.
2. 회사가 이용자에게 제공하는 거래내용 중 거래계좌의 명칭 또는 번호, 거래의 종류 및 금액, 거래 상대방 을 나타내는 정보, 거래일자, 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보와 해당 전자금융 거래와 관련한 전자적 장치의 접속기록은 5년간, 건당 거래금액이 1만원 이하인 소액 전자금융거래에 관한 기록, 전자지급수단 이용시 거래승인에 관한 기록, 이용자의 오류정정 요구 사실 및 처리결과에 관한 사항은 1년간의 기간을 대상으로 합니다.
3. 이용자가 제1항에서 정한 서면교부를 요청하고자 할 경우 다음의 주소 및 전화번호로 요청할 수 있습니다.
– 주소 : (04517) 서울특별시 중구 통일로 92 케이지타워 14,15층 ㈜케이지이니시스
– 이메일 주소 : sm@kggroup.co.kr
– 전화번호 : 1588-4954

제9조 (오류의 정정 등)
1. 이용자는 전자금융거래 서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대하여 그 정정을 요구할 수 있습니다.
2. 회사는 전항의 규정에 따른 오류의 정정요구를 받은 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받 은 날부터 2주 이내에 그 결과를 이용자에게 알려 드립니다.
3. 이용자는 전자금융거래 서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대하여 그 정정을 요구 할 수 있습니다.
4. 회사는 전항의 규정에 따른 오류의 정정요구를 받은 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받은 날부터 2주 이내에 그 결과를 이용자에게 알려 드립니다.

제10조 (회사의 책임)
1. 회사는 다음 각호의 사유 발생으로 인하여 ‘이용자’에게 손해가 발생하였을 경우 이에 대한 배상 책임이 있습니다.
– 접근매체의 위조나 변조로 발생한 사고
– 계약체결 또는 거래지시의 전자적 전송이나 처리 과정에서 발생한 사고
– 전자금융거래를 위한 전자적 장치 또는 ‘정보통신망’에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한 사고
2. 본 조 제1항에도 불구하고 다음 각 호의 사유로 발생한 사고에 대해선, 그 책임의 전부 또는 일부를 ‘이용자’가 부담합니다
– 법인(‘중소기업기본법’ 제2조 제2항에 의한 소기업을 제외합니다)인 ‘이용자’에게 손해가 발생한 경우로 서 ‘회사’가 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한 경우
– ‘이용자’가 제7조 제2항을 위반하여 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공한 경우
– 제3자가 권한 없이 ‘이용자’의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 알 수 있었음에도 불구하고 ‘이용자’가 자신의 접근매체를 누설 또는 노출하거나 방치한 경우
– 제7조 제1항의 따른 확인 외에 보안강화를 위하여 전자금융거래 시 ‘회사’가 요구하는 추가적인 보안조 치를 요구하였음에도 불구하고 ‘이용자’가 정당한 사유 없이 이를 거부하여 ‘회사’의 정보통신망에 침입 하여 거짓이나 그 밖의 부정한 방법으로 사고가 발생한 경우
– 이용자가 제3호에 따른 추가적인 보안조치에 사용되는 접근매체에 대하여 다음 각 목의 어느 하나에 해 당하는 행위를 하여 ‘회사’의 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 사고가 발생한 경우
가. 누설 또는 방치한 행위
나. 제3자에게 대여하거나 그 사용을 위임한 행위 또는 양도나 담보의 목적으로 제공한 행위

제11조 (전자지급거래 계약의 효력)
1. 회사는 이용자의 거래지시가 전자지급거래에 관한 경우 그 지급절차를 대행하며, 전자지급거래에 관한 거래지시의 내용을 전송하여 지급이 이루어지도록 합니다.
2. 회사는 이용자의 전자지급거래에 관한 거래지시에 따라 지급거래가 이루어지지 않은 경우 수령한 자금을 이용자에게 반환하여야 합니다.

제12조 (거래지시의 철회)
1. 이용자는 전자지급거래에 관한 거래지시의 경우 지급의 효력이 발생하기 전까지 거래지시를 철회할 수 있습니다.
2. 전항의 지급의 효력이 발생 시점은 다음 각 호의 사유를 말합니다.
– 전자자금이체의 경우에는 거래지시된 금액의 정보에 대하여 수취인의 계좌가 개설되어 있는 금융기관 의 계좌이체 원장에 입금기록이 끝난 때
– 그 밖의 전자지급 수단으로 지급하는 경우에는 거래지시된 금액의 정보가 수취인의 계좌가 개설되어 있 는 금융기관의 전자적 장치에 입력이 끝난 때
3. 이용자는 지급의 효력이 발생한 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령상 청약의 철회의 방법 또는 본 약관 제5조에서 정한 바에 따라 결제대금을 반환받을 수 있습니다.

제13조 (전자지급결제 대행 서비스 이용 기록의 생성 및 보존)
1. 회사는 이용자가 전자금융거래의 내용을 추적, 검색하거나 그 내용에 오류가 발생한 경우에 이를 확인하 거나 정정할 수 있는 기록을 생성하여 보존합니다.
2. 전항의 규정에 따라 회사가 보존하여야 하는 기록의 종류 및 보존방법은 제8조 제2항에서 정한 바에 따릅 니다.

제14조 (분쟁처리 및 분쟁조정)
회사는 전자금융거래 서비스를 제공함에 있어서 취득한 이용자의 인적사항, 이용자의 계좌, 접근매체 및 전자금융거래의 내용과 실적에 관한 정보 또는 자료를 이용자의 동의를 얻지 아니하고 제3자에게 제공,누설하거나 업무상 목적 외에 사용하지 아니합니다. 다만 「금융실명거래 및 비밀보장에 관한 법률」 제4조 제1항 단서의 규정에 따른 경우 및 그 밖에 다른 법률에서 정하는 바에 따른 경우에는 그러하지 아니하다.

제15조 (전자금융 거래정보의 제공금지)
1. 이용자는 다음의 분쟁처리 책임자 및 담당자에 대하여 전자금융거래 서비스 이용과 관련한 의견 및 불만 의 제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다.
– 담당자 : RM팀
– 연락처(전화번호, FAX) : 3430-5847, 3430-5889
– E-mail : inirm@kggroup.co.kr
2. 이용자가 회사에 대하여 분쟁처리를 신청한 경우에는 회사는 15일 이내에 이에 대한 조사 또는 처리 결과 를 이용자에게 안내합니다.
3. 이용자는 ‘금융감독기구의 설치 등에 관한 법률’ 제51조의 규정에 따른 금융감독원의 금융분쟁조정위원회 나 ‘소비자보호법’ 제31조 제1항의 규정에 따른 소비자보호원에 회사의 전자금융거래 서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다.

제16조 (회사의 안정성 확보 의무)
회사는 전자금융거래의 안전성과 신뢰성을 확보할 수 있도록 전자금융거래의 종류별로 전자적 전송이나 처리를 위한 인력, 시설, 전자적 장치 등의 정보기술부문 및 전자금융업무에 관하여 금융감독위원회가 정하는 기준을 준수합니다.

제17조 (약관 외 준칙 및 관할)
1. 이 약관에서 정하지 아니한 사항에 대하여는 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다.
2. 회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.
부칙 (2010년 4월 12일)
– 최초 시행일자 : 2007년 1월 1일
– 변경 공고일자 : 2019년 4월 23일
– 변경 시행일자 : 2019년 5월 23일</textarea>
					</div>
				</div>
				<button type="button" class="btn btn-EA5C2B btn-d-pay" id="requestPay">주문하기</button>
			</div>
		</div>
	</form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 상품 금액, 배송비, 합계
window.addEventListener('load', (e) => {
	// 상품 금액
	const productPrice = document.querySelectorAll(".dOrder-price");
	const productTotalPrice = document.querySelector("[name=dProductPrice]");
	
	const price = [...productPrice].map((p) => parseInt(p.innerHTML.replace(",", ""))).reduce((total, price) => total + price, 0);
	console.log(price);
	
	productTotalPrice.value = price.toLocaleString('ko-KR');
	
	// 배송비
	const seller = document.querySelectorAll("[name=seller]");
	const deliveryFee = document.querySelector("[name=dDeliveryFee]");
	let allSeller = new Set();
	
	seller.forEach((seller) => {
		allSeller.add(seller.value);
	})
	
	const totalDeliveryFee = allSeller.size * 3000;
		
	deliveryFee.value = totalDeliveryFee.toLocaleString('ko-KR');
	
	// 합계
	const totalPriceVal = price + totalDeliveryFee;
	const totalPrice = document.querySelector("[name=dPrice]");
	const finalPrice = document.querySelector(".d-price");
	const dTotalPrice = document.querySelector("[name=dTotalPrice]");
	
	totalPrice.value = totalPriceVal.toLocaleString('ko-KR');
	finalPrice.innerHTML = totalPriceVal.toLocaleString('ko-KR');
	dTotalPrice.value = totalPriceVal;
	
});


// 이용약관
$(function (){
	$("#privacyAgree1-overview").click(function (){
  	$("#toggle1").toggle();
  });
});
$(function (){
	$("#privacyAgree2-overview").click(function (){
  	$(".toggle2").toggle();
  });
});

$("#all-privacyAgree").click(function() {
	if($("#all-privacyAgree").is(":checked")) {
		$("input[name=privacyAgree]").prop("checked", true);
		$("#all-privacyAgree").next().css("color", "inherit");
	}
	else {
		$("input[name=privacyAgree]").prop("checked", false);
		$("#all-privacyAgree").next().css("color", "#afb0b3");
	}
});

$("input[name=privacyAgree]").click(function() {
	let total = $("input[name=privacyAgree]").length;
	let checked = $("input[name=privacyAgree]:checked").length;
	
	if(total != checked) {
		$("#all-privacyAgree").prop("checked", false);
		$("#all-privacyAgree").next().css("color", "#afb0b3");
	}
	else {
		$("#all-privacyAgree").prop("checked", true);
		$("#all-privacyAgree").next().css("color", "inherit");
	}
});

// 결제수단 체크 표시/dPayments 값
const dPayments = document.querySelector("[name=dPayments]")
document.querySelectorAll("[name=d-card]").forEach((pay) => {
	pay.addEventListener('change', (e) => {
		if(e.target.id == 'd-card-kg') {
			e.target.parentElement.classList.add('payCheck');
			e.target.parentElement.nextElementSibling.classList.remove('payCheck');
			dPayments.value = "카드";
		}
		else {
			e.target.parentElement.classList.add('payCheck');
			e.target.parentElement.previousElementSibling.classList.remove('payCheck');
			dPayments.value = "카카오페이";
		}
	});
});

//주소 유효성 검사
document.querySelector("#dDestAddress").addEventListener('input', (e) => {
	const dDestAddress = e.target;
	const error = document.querySelector(".dDestAddressCheck.error");
	if(!/^[\S].+$/.test(dDestAddress.value)){
		error.style.display = "block";
		dDestAddress.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		dDestAddress.style.borderBottom = "1px solid #116530";
	}
});
// 핸드폰번호 유효성 검사
document.querySelector("#dOrderPhone").addEventListener('input', (e) => {
	const dOrderPhone = e.target;
	const error = document.querySelector(".dOrderPhoneCheck.error");
	if(!/^[0-9]{10,}$/.test(dOrderPhone.value)){
		error.style.display = "block";
		dOrderPhone.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		dOrderPhone.style.borderBottom = "1px solid #116530";
	}
});

document.querySelector("#dOrderPhone").addEventListener('blur', (e) => {
	const dOrderPhone = e.target;
	const error = document.querySelector(".dOrderPhoneCheck.error");
	if(!/^[0-9]{10,}$/.test(dOrderPhone.value)){
		error.style.display = "block";
		dOrderPhone.style.borderBottom = "1px solid red";
		dOrderPhone.select();
		return;
	}
	else {
		error.style.display = "none";
		dOrderPhone.style.borderBottom = "1px solid #116530";
	}
});

// 수령인 유효성 검사
document.querySelector("#dRecipient").addEventListener('input', (e) => {
	const dRecipient = e.target;
	const error = document.querySelector(".dRecipientCheck.error");
	if(!/^[a-zA-z가-힣]+$/.test(dRecipient.value)){
		error.style.display = "block";
		dRecipient.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		dRecipient.style.borderBottom = "1px solid #116530";
	}
});

document.querySelector("#dRecipient").addEventListener('blur', (e) => {
	const dRecipient = e.target;
	const error = document.querySelector(".dRecipientCheck.error");
	if(!/^[a-zA-z가-힣]+$/.test(dRecipient.value)){
		error.style.display = "block";
		dRecipient.style.borderBottom = "1px solid red";
		dRecipient.select();
		return;
	}
	else {
		error.style.display = "none";
		dRecipient.style.borderBottom = "1px solid #116530";
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
			document.getElementById("dDestAddress").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("dDestAddressEx").focus();
		}
	}).open();
});

// 주문 처리
document.querySelector("#requestPay").addEventListener('click', (e) => {
	
	// 약관 동의 확인
	if(!document.querySelector("#all-privacyAgree").checked) {
		alert('모든 동의가 완료되지 않았습니다.');
		return;
	}
	
	const frm = document.directPayFrm;
	const optionNo = document.querySelectorAll("[name=dOptionNo]");
	const productNo = document.querySelectorAll("[name=dProductNo]");
	const productCount = document.querySelectorAll("[name=productCount]");
	let pg = document.querySelector("[name=d-card]:checked").value;
	const memberName = frm.dRecipient.value;
	const memberTel =  frm.dOrderPhone.value;
	const memberEmail = frm.memberEmail.value;
	const payAmount = frm.dTotalPrice.value;
	
	let optionNoList = [];
	[...optionNo].forEach((no) => {
		optionNoList.push(no.value);
	});
	let productNoList = [];
	[...productNo].forEach((no) => {
		productNoList.push(no.value);
	});
	let productCountList = [];
	[...productCount].forEach((no) => {
		productCountList.push(no.value);
	});
		
	let productNameAll = [];
	document.querySelectorAll(".dOrder-productName").forEach((name) => {
		productNameAll.push(name.innerHTML);
	});
	let productName;
	if(productNameAll.length === 1) {
		productName = productNameAll[0];
	}
	else {
		productName = productNameAll[0] + " 외";
	}	
	
	// 재고 확인
	let targetStock = document.querySelectorAll("[name=dStock]");
	let targetProductList = [];
	let available = true;
	targetStock.forEach((stock) => {
		console.dir(stock);
		const targetCount = parseInt(stock.previousElementSibling.value);
		const targetProductName = stock.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.firstElementChild.innerHTML;
		const targetOptionName = stock.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.lastElementChild.innerHTML;
		const targetProduct = targetProductName + ' ' + targetOptionName;
		if(targetCount > parseInt(stock.value)) {
			targetProductList.push(' ' + targetProduct);
			available = false;
			return;
		}
	});
	
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	console.log(headers);
	
	if(available === false) {
		alert(`죄송합니다. 해당 상품은 품절되었습니다. 다음에 이용해 주세요.😥
[\${targetProductList} ]`);
		return;
	}
	else {
		if(pg == 'kg'){
			pg = 'html5_inicis';
		}
		if(pg == 'kakaoPay'){
			pg = 'kakaopay';
		}
		
	 	var IMP = window.IMP; // 생략가능  
	 	IMP.init("imp83181016"); // 가맹점식별코드 
	 	IMP.request_pay({
			pg: pg,
			pay_method: 'card',
			name: productName,
			// amount: 100,
			amount: payAmount,
			buyer_name: memberName,
			buyer_tel: memberTel,
			buyer_email: memberEmail,
		}, function (rsp) {
			console.log(rsp); 
   			if (rsp.success) {
				$.ajax({
					url : "${pageContext.request.contextPath}/direct/directPay.do",
					method : "POST",
					headers,
 					data : {memberId : frm.memberId.value,
 							dTotalPrice : payAmount,
 							dDestAddress : dDestAddress.value,
 							dDestAddressEx : dDestAddressEx.value,
 							dDeliveryRequest : dDeliveryRequest.value,
 							dRecipient : dRecipient.value,
 							dOrderPhone : dOrderPhone.value,
 							dPayments : dPayments.value,
 							optionNoList : optionNoList,
 							productNoList : productNoList,
 							productCountList : productCountList},
					success(response) {
						alert(`주문이 성공적으로 완료되었습니다.
[주문번호 : \${response.dOrderNo}]

해당 페이지로 이동합니다.`);
						location.href = `${pageContext.request.contextPath}/member/memberDirectDetail.do?dOrderNo=\${response.dOrderNo}`;
					},
					error : console.log
				});
			} else {
				alert(`결제에 실패하였습니다. 다시 주문해 주세요`);
			}
		});
	}
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>