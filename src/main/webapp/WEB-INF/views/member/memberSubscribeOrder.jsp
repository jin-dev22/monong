<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="${pageContext.request.contextPath}/resources/js/subscribeOrder.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/subscribe/sPlan.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<div class="s-form-container mx-auto">
	<form:form name="subscribePlanUpdateFrm" method="post" action="${pageContext.request.contextPath}/member/memberSubscribeOrderUpdate.do">
    <!-- 주문번호, 구독번호 -->
    <input type="hidden" name="sNo" value="${recentSubscription.SNo}" />
    <div class="s-form-part-container">
        <h2 class="s-form-part-title">상품 선택</h2>  
        <div class="s-products-container d-flex justify-content-between">
			<c:if test="${not empty subscriptionProduct}">
				<c:forEach items="${subscriptionProduct}" var="product" varStatus="vs">
					<div class="s-product-container img-thumbnail ${recentSubProduct.SProductCode eq product.SProductCode ? 'selected' : ''}" data-sproduct="${product.SProductCode}" data-index="${vs.index}">
		                <div>
		                    <img src="${pageContext.request.contextPath}/resources/images/subscribe/${product.SProductName}.jpg" alt="${product.SProductName}" width="300px">
		                </div>
		                <span class="s-product-name">${product.SProductName}</span>
		                <span class="s-product-price">
		                	<fmt:formatNumber value="${product.SProductPrice}" pattern="#,###원" />
		                </span>
		                <span class="s-product-info">${product.SProductInfo}용</span>
		            </div>
				</c:forEach>
			</c:if>
            <input type="hidden" name="sProductCode" value="${recentSubProduct.SProductCode}" id="sProduct"> 
        </div>
    </div>

    <div class="s-form-part-container">
        <h2 class="s-form-part-title">제외 채소 선택</h2>
        <span>제외할 채소가 있다면 선택해주세요. 최대 5개까지 선택하실 수 있습니다.</span>
        <div class="exclude-vegs-cnt-info" style="display:none">
	        <span class="exclude-vegs-cnt"></span>
	        <span>/&nbsp5개</span>
        </div>
        <div class="s-no-exclude-check form-check">
            <input class="form-check-input" name="sExcludeVegs" type="checkbox" value="없음" id="noExcludeVegsCheck" ${recentSubscription.SExcludeVegs eq null ? 'checked' : ''}>
            <label class="form-check-label" for="noExcludeVegsCheck">
            제외 채소 선택 안함
            </label>
        </div>
    
        <c:if test="${not empty vegetables}">
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">과일류</h5>
	            <div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '과일류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${recentSubscription.SExcludeVegs.contains(veg.vegName) ? 'checked' : ''}>
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">과채류</h5>
	            <div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '과채류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${recentSubscription.SExcludeVegs.contains(veg.vegName) ? 'checked' : ''}>
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">채소류</h5>
	            <div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '채소류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${recentSubscription.SExcludeVegs.contains(veg.vegName) ? 'checked' : ''}>
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
			<div class="s-vegs-category-wrapper">
            	<h5 class="s-vegs-category-title">엽/양채류</h5>
            	<div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '엽/양채류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${recentSubscription.SExcludeVegs.contains(veg.vegName) ? 'checked' : ''}>
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
			<div class="s-vegs-category-wrapper">
	            <h5 class="s-vegs-category-title">근채류</h5>
           		<div class="s-vegs-category d-flex justify-content-start flex-wrap">
					<c:forEach items="${vegetables}" var="veg" varStatus="vs">
						<c:if test="${veg.vegCategory eq '근채류'}">
			         		<div class="form-check form-check-inline">
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}" ${recentSubscription.SExcludeVegs.contains(veg.vegName) ? 'checked' : ''}>
			                    <label class="form-check-label" for="veg${vs.count}">${veg.vegName}</label>
			                </div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			
		</c:if>
    </div>

    <div class="s-form-part-container">
        <h2 class="s-form-part-title">배송 주기 선택</h2>
        <div class="s-vegs-category d-flex justify-content-start flex-wrap">
	        <div class="form-check form-check-inline">
	            <input class="form-check-input" type="radio" name="sDeliveryCycle" id="deliveryCycle1" value="1" ${recentSubscription.SDeliveryCycle eq "1" ? 'checked' : ''}>
	            <label class="form-check-label" for="deliveryCycle1">1주</label>
	        </div>
	        <div class="form-check form-check-inline">
	            <input class="form-check-input" type="radio" name="sDeliveryCycle" id="deliveryCycle2" value="2" ${recentSubscription.SDeliveryCycle eq "2" ? 'checked' : ''}>
	            <label class="form-check-label" for="deliveryCycle2">2주</label>
	        </div>
	        <div class="form-check form-check-inline">
	            <input class="form-check-input" type="radio" name="sDeliveryCycle" id="deliveryCycle3" value="3" ${recentSubscription.SDeliveryCycle eq "3" ? 'checked' : ''}>
	            <label class="form-check-label" for="deliveryCycle3">3주</label>
	        </div>
        </div>
    </div>
    
    <div class="s-order-addr-info">
			<h2 class="s-form-part-title">배송지 정보</h2>
			<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"/>" />
			<div class="mypage-order-addr-info-content">
				<label for="sRecipient">수령인</label><br />
				<input type="text" id="sRecipient" name="sRecipient" value="${recentSubscription.SRecipient}" required /><br/>
				<span class="sRecipientCheck error">수령인을 입력해주세요.</span><br /><br />
				<label for="sPhone">연락처</label><br />
				<input type="text" id="sPhone" name="sPhone" value="${recentSubscription.SPhone}" required /><br/>
				<span class="sPhoneCheck error">연락처는 '-'없이 숫자만 입력해주세요.</span><br /><br />
				<label for="sAddress">주소</label><br />
				<input type="text" id="sAddress" name="sAddress" value="${recentSubscription.SAddress}" required readonly />
				<input type="button" id="researchButton" value="검색" class="btn btn-EA5C2B"><br />
				<span class="sAddressCheck error">받으실 주소를 입력해주세요.</span><br /><br />
				<label for="sAddressEx">상세주소</label><br />
				<input type="text" id="sAddressEx" name="sAddressEx" value="${recentSubscription.SAddressEx}" required /><br/><br />
				<label for="sDeliveryRequest">배송 요청사항(선택)</label><br />
				<input type="text" id="sDeliveryRequest" name="sDeliveryRequest" value="${recentSubscription.SDeliveryRequest eq null ? '' : recentSubscription.SDeliveryRequest}">
			</div>
		</div>
		
	<div class="mypage-s-delay-container">
		<h2 class="s-form-part-title">배송미루기</h2>
		<span>배송 미루기는 일주일 단위로만 가능합니다.</span>
		<div class="s-delay-check-container">
			<h4>다음 결제일</h4><br />
			<h3 id="nextPaymentDate" class="pb-3">${recentSubscription.SPaymentDate}</h3>
			<h4>다음 배송일</h4><br />
			<h3 id="nextDeliveryDate" class="pb-3">${recentSubscription.SNextDeliveryDate}</h3>

			<input type="hidden" name="sNextDeliveryDate" id="sNextDeliveryDate" value="${recentSubscription.SNextDeliveryDate}" />
			<input type="hidden" name="sPaymentDate" id="sPaymentDate" value="${recentSubscription.SPaymentDate}" />
			<input type="checkbox" name="sDelayYn" id="sDelayYn" value="${recentSubscription.SDelayYn}" ${recentSubscription.SDelayYn eq 'Y' ? 'checked' : ''}/>
			<label for="sDelayYn">배송미루기</label>
		</div>
	</div>
    <p class="pt-5">※ 정기결제일 이후에 수정하시는 경우, 다음 배송부터 해당 플랜이 적용됩니다 :)</p>
    
    <input type="submit" class="btn btn-EA5C2B btn-subscribe-apply" value="수정하기">
    
	</form:form>

</div>


<script>
const recentPayDate = "<c:out value='${recentSubscription.SPaymentDate}'/>";
const recentDate = "<c:out value='${recentSubscription.SNextDeliveryDate}'/>";
const recentCycle = "<c:out value='${recentSubscription.SDeliveryCycle}'/>";

const delayYn = document.querySelector("#sDelayYn");
const deliveryDate = document.querySelector("#sNextDeliveryDate");
const payDate = document.querySelector("#sPaymentDate");

const today = Date.now();
const cycles = document.querySelectorAll('input[type=radio][name="sDeliveryCycle"]');
const productCode = document.querySelector("#sProduct").value;


cycles.forEach(cycle => cycle.addEventListener('change', ()=> {
	//새로들어갈 일자
	let deliveryFormatDate = new Date(recentDate);
	let payFormatDate = new Date(recentPayDate);
	
	
	//변동없을 시(기존과 같은 것을 클릭), 다음배송일 그대로
	if(recentCycle == cycle.value){
		deliveryFormatDate.setDate(deliveryFormatDate.getDate());
		payFormatDate.setDate(payFormatDate.getDate());
	}
	
	//변동했을 시, 수정 한 주기로 다음배송일 변경 
	if(recentCycle != cycle.value){
		if(recentCycle < cycle.value){
			deliveryFormatDate.setDate(deliveryFormatDate.getDate() + ((cycle.value - recentCycle) * 7));
			payFormatDate.setDate(payFormatDate.getDate()+ ((cycle.value - recentCycle) * 7));
		}
		else{
			if(today.valueOf() < (payFormatDate.setDate(payFormatDate.getDate() - ((recentCycle - cycle.value) * 7))).valueOf()){
				deliveryFormatDate.setDate(deliveryFormatDate.getDate() - ((recentCycle - cycle.value) * 7));
				
			}
			else{
				deliveryFormatDate.setDate(deliveryFormatDate.getDate());
				payFormatDate.setDate(payFormatDate.getDate());
			}
		}
	}
	
	let dY = deliveryFormatDate.getFullYear();
	let dM = deliveryFormatDate.getMonth() + 1;
	let dD = deliveryFormatDate.getDate();

	const dDate = dateFormat(dY,dM,dD);
	deliveryDate.value = dDate;
	
	let pY = payFormatDate.getFullYear();
	let pM = payFormatDate.getMonth() + 1;
	let pD = payFormatDate.getDate();
	
	const pDate = dateFormat(pY,pM,pD);
	payDate.value = pDate;
	
	
	
	$("#nextDeliveryDate").text(deliveryDate.value);
	$("#nextPaymentDate").text(payDate.value);
})); 

function dateFormat(year,month,date){
	month = month < 10 ? '0' + month : month;
	date = date < 10 ? '0' + date : date;
	return year+"-"+month+"-"+date;
};

delayYn.addEventListener('click', (e)=>{
	
	//새로들어갈 일자
	let deliveryFormatDate = new Date(deliveryDate.value);
	let payFormatDate = new Date(payDate.value);
	
	if(delayYn.checked == true){
		alert('다음 배송을 일주일 미루셨습니다.');
		delayYn.value = 'Y';
		
		deliveryFormatDate.setDate(deliveryFormatDate.getDate() + 7);
		payFormatDate.setDate(payFormatDate.getDate() + 7);
	}
	if(delayYn.checked == false){
		alert('미루기를 취소하였습니다.');
		delayYn.value = 'N';
		
		deliveryFormatDate.setDate(deliveryFormatDate.getDate() - 7);
		payFormatDate.setDate(payFormatDate.getDate() - 7);
	}
	
	let dY = deliveryFormatDate.getFullYear();
	let dM = deliveryFormatDate.getMonth() + 1;
	let dD = deliveryFormatDate.getDate();

	const dDate = dateFormat(dY,dM,dD);
	deliveryDate.value = dDate;
	
	let pY = payFormatDate.getFullYear();
	let pM = payFormatDate.getMonth() + 1;
	let pD = payFormatDate.getDate();
	
	const pDate = dateFormat(pY,pM,pD);
	payDate.value = pDate;
	
	$("#nextDeliveryDate").text(deliveryDate.value);
	$("#nextPaymentDate").text(payDate.value);
	
});


const products = document.querySelectorAll(".s-product-container");

products.forEach(function (product, index){
    product.addEventListener('click', (e) => {
 		// console.log(product);
        product.classList.add("selected");
        
        products.forEach(function (prod, i){
        	// 선택되지 않은 상품들 테두리 제거
            if(index !== Number(prod.dataset.index)){
            	prod.classList.remove("selected");
            }
        });

        // 선택한 상품값 저장
        document.querySelector("#sProduct").value = product.dataset.sproduct;
        console.log(document.querySelector("#sProduct").value);
    });
});


const vegs = document.querySelectorAll(".s-vegs-category [name=sExcludeVegs]");
const noExcludeVegsCheck = document.querySelector("#noExcludeVegsCheck");
const excludeVegsNum = document.querySelector(".exclude-vegs-cnt");
const excludeVegsCntInfo = document.querySelector(".exclude-vegs-cnt-info");

let excludeVegsCnt = 0;
noExcludeVegsCheck.addEventListener('change', (e) => {
	// '제외 채소 선택 안함' 체크 시
    if(noExcludeVegsCheck.checked === true){
        excludeVegsCnt = 0; // 선택한 제외채소 개수 초기화
        excludeVegsCntInfo.style.display = "none";
        
        vegs.forEach((veg)=>{
            veg.checked = false; // 선택한 제외채소 체크 제거
        });
    }
});

vegs.forEach((veg)=>{
    veg.addEventListener('change', (e) => {
        // console.log(e.target);
        if(e.target.checked === true){
        	excludeVegsCntInfo.style.display = "initial";
      
            if(excludeVegsCnt < 5){
                excludeVegsCnt++;
                excludeVegsCntInfo.style.color = "black";
                excludeVegsNum.innerHTML = excludeVegsCnt;
                noExcludeVegsCheck.checked= false;
            }
            else{
            	excludeVegsCntInfo.style.color = "red";
                alert('최대 5개까지만 선택 가능합니다.');
                e.target.checked = false;
            }
        }
        else{
            excludeVegsCnt--;
            excludeVegsCntInfo.style.color = "black";
            excludeVegsNum.innerHTML = excludeVegsCnt;
        }
        // console.log(excludeVegsCnt);
        
    });
});


subscribePlanUpdateFrm.addEventListener('submit', (e) => {
	const sExcludeVegsYn = document.querySelector("[name=sExcludeVegs]");
	console.log(sExcludeVegsYn.checked);
	console.log(excludeVegsCnt);
	
	if(sExcludeVegsYn.checked == false && excludeVegsCnt === 0){
		alert("제외 채소 유무를 선택해주세요.");
		e.preventDefault();
		return;
	}
	
	const sDeliveryCycleYnArr = []; // 배송 주기 선택 여부 담는 배열
	const sDeliverCycles = document.querySelectorAll("[name=sDeliveryCycle]");
	
	sDeliverCycles.forEach(function (cycle, index) {
		// console.log(cycle.checked);
		sDeliveryCycleYnArr.push(cycle.checked);
		// console.log(sDeliveryCycleYnArr);
	});
	
	if(sDeliveryCycleYnArr.indexOf(true) === -1){
		alert("배송 주기를 선택해주세요.");
		e.preventDefault();
	}
	
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>