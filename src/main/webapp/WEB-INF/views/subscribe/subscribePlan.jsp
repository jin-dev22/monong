<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.kh.monong.member.model.dto.Member"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/subscribe/sPlan.css">
<h1 class="s-plan">구독 플랜</h1>

<div class="s-form-container mx-auto">
	<!-- 9/7 선아 액션주소 변경 -->
	<form:form name="subscribePlanFrm" method="post" action="${pageContext.request.contextPath}/subscribe/subscribeOrder.do">
    <div class="s-form-part-container">
        <h2 class="s-form-part-title">상품 선택</h2>  
        <div class="s-products-container d-flex justify-content-between">
			<c:if test="${not empty subscriptionProduct}">
				<c:forEach items="${subscriptionProduct}" var="product" varStatus="vs">
					<div class="s-product-container img-thumbnail" data-sproduct="${product.SProductCode}" data-index="${vs.index}">
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
            <input type="hidden" name="sProduct" value="SP1" id="sProduct"> 
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
            <input class="form-check-input" name="sExcludeVegs" type="checkbox" value="없음" id="noExcludeVegsCheck">
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
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}">
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
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}">
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
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}">
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
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}">
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
			                    <input class="form-check-input" name="sExcludeVegs" type="checkbox" id="veg${vs.count}" value="${veg.vegName}">
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
	            <input class="form-check-input" type="radio" name="sDeliveryCycle" id="deliveryCycle1" value="1">
	            <label class="form-check-label" for="deliveryCycle1">1주</label>
	        </div>
	        <div class="form-check form-check-inline">
	            <input class="form-check-input" type="radio" name="sDeliveryCycle" id="deliveryCycle2" value="2">
	            <label class="form-check-label" for="deliveryCycle2">2주</label>
	        </div>
	        <div class="form-check form-check-inline">
	            <input class="form-check-input" type="radio" name="sDeliveryCycle" id="deliveryCycle3" value="3">
	            <label class="form-check-label" for="deliveryCycle3">3주</label>
	        </div>
        </div>
    </div>

    <p>※ 구독 플랜은 결제예정일 전까지 언제든 변경하실 수 있습니다 :)</p>
    <input type="submit" class="btn btn-EA5C2B btn-subscribe-apply" value="신청하기">
    
	</form:form>

</div>


<script>   
document.querySelector(".s-product-container:nth-of-type(1)").classList.add("selected");

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
        // console.log(document.querySelector("#sProduct").value);
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


subscribePlanFrm.addEventListener('submit', (e) => {
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