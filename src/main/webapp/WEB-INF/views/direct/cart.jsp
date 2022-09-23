﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/direct/direct.css" />
<h2 class="cart-title">장바구니</h2>
<div class="dCart_selected">
	<form:form name="CartFrm" method="POST" action="${pageContext.request.contextPath}/direct/directOrder.do">
		<h4>선택상품</h4>
		<div class="dCartProduct-info">
			<div class="dCartProduct-info-content">
				<sec:authentication property="principal" var="loginMember"/>
				<input type="hidden" id="memberId" value="${loginMember.memberId}" />
				<div class="checkbox-container">
					<div class="checkbox-line">
						<label class="checkedAll" for="checkedAll">
							<input id="checkedAll" type="checkbox" />전체선택
						</label>
						<span class="checkbox-bar"></span>
						<button id="checkedDelete" class="checkedDelete" type="button">선택삭제</button>
					</div>
					<button type="button" id="allClear" class="btn allClear btn-116530">장바구니 비우기</button>
				</div>
				<c:if test="${empty cartList}">
					<div style="display: flex; justify-content: center;">
						<p style="text-align: center; margin: 40px 0; font-size: 20px;">장바구니가 비어있습니다.
							<img alt="장바구니 없음" src="${pageContext.request.contextPath}/resources/images/cart.png" style="filter: grayscale(1); width: 250px; margin-top: 25px;">
						</p>
					</div>
				</c:if>
				<c:if test="${not empty cartList}">
					<ul class="dCart-info">
						<c:forEach items="${cartList}" var="cartList">
							<li class="cart-list">
								<label class="checkedOne" for="checkedOne">
									<input id="checkedOne" name="checkedOne" type="checkbox" />
								</label>
								<div class="dCart-img-container">
									<a href="${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${cartList.directProduct.DProductNo}">
										<span class="dCart-img" style="background-image: url(${pageContext.request.contextPath}/resources/upload/product/${cartList.directProductAttachments[0].DProductRenamedFilename});"></span>
									</a>
								</div>
								<div class="dCart-name-container">
									<a href="${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${cartList.directProduct.DProductNo}" class="dCart-name">
										<p class="dCart-productName">${cartList.directProduct.DProductName}</p>
										<p class="dCart-optionName">[옵션] ${cartList.directProductOption.DOptionName}</p>
										<input type="hidden" name="seller" value="${cartList.directProduct.memberId}"/>
										<input type="hidden" name="dPrice" value="${cartList.directProductOption.DPrice}"/>
									</a>					
								</div>
								<div class="dCart-count-container">
									<button class="dCart-minus-btn" id="minus" name="pm-btn" type="button">-</button>
									<div class="dCart-count">${cartList.productCount}</div>
									<button class="dCart-plus-btn" id="plus" name="pm-btn" type="button">+</button>
								</div>
								<div class="dCart-price-container">
									<span class="dCart-price"><fmt:formatNumber pattern="#,###">${cartList.productCount * cartList.directProductOption.DPrice}</fmt:formatNumber></span><span> 원</span>				
								</div>
								<input type="hidden" name="cartNo" value="${cartList.cartNo}"/>
								<input type="hidden" name="dOptionNo" value="${cartList.directProductOption.DOptionNo}"/>
								<input type="hidden" name="productCount" value="${cartList.productCount}"/>
								<input type="hidden" name="memberId" value="${loginMember.memberId}" />
								<input type="hidden" name="dStock" value="${cartList.directProductOption.DStock}" />
								<button id="targetDelete" class="dCart-delete-btn" type="button">x</button>
							</li>
						</c:forEach>
					</ul>
				</c:if>
			</div>
		</div>
		<div class="dCartProduct-pay-info">
			<table class="tbl-dCartProduct-pay">
				<thead>
					<tr>
						<th>총 상품금액</th>
						<th style="width: 30px;"></th>
						<th>총 배송비<br /><span style="font-size: 14px; color: #afb0b3;">(판매자별)</span></th>
						<th style="width: 30px;"></th>
						<th>결제예정금액</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><span class="dTotalProductPrice"></span></td>
						<td style="width: 30px;"><img style="width: 30px;" alt="plus" src="${pageContext.request.contextPath}/resources/images/plus.png"></td>
						<td><span class="dTotalDeliveryFee"></span></td>
						<td style="width: 30px;"><img style="width: 30px;" alt="equal" src="${pageContext.request.contextPath}/resources/images/equal.png"></td>
						<td><span class="dTotalPrice"></span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="dCartProduct-pay-btn">
			<button style="margin: 0 8px; font-size: 14px;" type="button" id="orderAll" name="orderBtn" class="btn checkedAllOrder btn-EA5C2B">전체상품주문</button>
			<button style="margin: 0 2px; font-size: 14px;" type="button" id="orderChecked" name="orderBtn" class="btn checkedOrder btn-EA5C2B-reverse">선택상품주문</button>
		</div>
	</form:form>
</div>
<script>
// 체크박스 선택
$("#checkedAll").click(function() {
	if($("#checkedAll").is(":checked")) {
		$("input[name=checkedOne]").prop("checked", true);
	}
	else {
		$("input[name=checkedOne]").prop("checked", false);
	}
});

$("input[name=checkedOne]").click(function() {
	let total = $("input[name=checkedOne]").length;
	let checked = $("input[name=checkedOne]:checked").length;
	
	if(total != checked) {
		$("#checkedAll").prop("checked", false);
	}
	else {
		$("#checkedAll").prop("checked", true);
	}
});

// 버튼 핸들러
document.querySelectorAll("button").forEach((button) => {
	button.addEventListener('click', (e) => {
		const memberId = document.querySelector("#memberId").value;
		
		// 장바구니 비우기
		if(e.target.id === "allClear") {
			$.ajax({
				url : "${pageContext.request.contextPath}/direct/deleteCartAll.do",
				method : "GET",
				data : {memberId},
				success(response) {
					location.reload();
				},
				error : console.log
			});
		}
		
		// 한 상품 삭제
		else if(e.target.id === "targetDelete") {
			const cartNo = e.target.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.value;
			console.dir(e.target);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/direct/deleteCartTarget.do",
				method : "GET",
				data : {cartNo},
				success(response) {
					location.reload();
				},
				error : console.log
			});
		}
		
		// 체크된 상품 삭제
		else if(e.target.id === "checkedDelete") {
			const checkedOne = document.querySelectorAll("[name=checkedOne]");
			let checkedArr = [];
			
			checkedOne.forEach((one) => {
				if(one.checked) {
					checkedArr.push(one.parentElement.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.value);
				}
			});
			
			console.log(checkedArr);
			
			if(checkedArr.length !== 0 && Array.isArray(checkedArr)) {
				$.ajax({
					url : "${pageContext.request.contextPath}/direct/deleteCartChecked.do",
					method : "GET",
					data : {checkedArr},
					success(response) {
						location.reload();
					},
					error : console.log
				});
			}
		}
		
		// 수량 업데이트
		else if(e.target.name === "pm-btn") {
			const cartNo = e.target.parentElement.nextElementSibling.nextElementSibling.value;
			let productCount = e.target.parentElement.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling;
			
			if(e.target.id === "plus") {
				let countVal = Number(e.target.previousElementSibling.innerHTML);
				const count = e.target.previousElementSibling;
				const checkStock = Number(e.target.parentElement.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.value);
				countVal++;
				if(countVal < 5) {
					if(countVal < checkStock) {
						count.innerHTML = countVal;	
						productCount.value = countVal;
					}
					else if(countVal = checkStock) {
						count.innerHTML = countVal;	
						productCount.value = countVal;
						setTimeout(() => {
							alert('현재 주문 가능한 최대 수량입니다.');
						}, 250);
					}
				}
				else if(countVal = 5) {
					if(countVal < checkStock) {
						count.innerHTML = countVal;	
						productCount.value = countVal;
					}	
					else if(countVal = checkStock) {
						count.innerHTML = countVal;	
						productCount.value = countVal;
						setTimeout(() => {
							alert('현재 주문 가능한 최대 수량입니다.');
						}, 250);
					}
					setTimeout(() => {
						alert('최대 주문 가능 수량은 5개입니다.');
					}, 250);
						
				}
				
				const defaultPriceVal = parseInt(e.target.parentElement.previousElementSibling.firstElementChild.lastElementChild.value);
				const sumVal = countVal * defaultPriceVal;

				e.target.parentElement.nextElementSibling.firstElementChild.innerHTML = sumVal.toLocaleString('ko-KR');
				
				totalCalc();				
			}
			else if(e.target.id === "minus") {
				let countVal = Number(e.target.nextElementSibling.innerHTML);
				const count = e.target.nextElementSibling;
				countVal--;
				if(countVal > 0) {
					count.innerHTML = countVal;
					productCount.value = countVal;
				}
				else if(countVal = 1) {
					count.innerHTML = countVal;
					productCount.value = countVal;
				}
				
				const defaultPriceVal = parseInt(e.target.parentElement.previousElementSibling.firstElementChild.lastElementChild.value);
				const sumVal = countVal * defaultPriceVal;

				e.target.parentElement.nextElementSibling.firstElementChild.innerHTML = sumVal.toLocaleString('ko-KR');
				
				totalCalc();
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/direct/updateCartProductCount.do",
				method : "GET",
				data : {cartNo, 
						productCount : productCount.value},
				success(response) {
				},
				error : console.log
			});
		}
		else if(e.target.name === "orderBtn") {
			const frm = document.CartFrm;
			const li = document.querySelectorAll(".cart-list");
						
			if(li.length > 0) {
			const checkedOne = document.querySelectorAll("[name=checkedOne]");

				if(e.target.id === "orderAll") {
					checkedOne.forEach((one) => {
						one.checked = true;
						document.querySelector("#checkedAll").checked = true;
					})
				}
				const checkedCount = $("input:checkbox[name=checkedOne]:checked").length;
				
				if(checkedCount > 0) {
					$("input:checkbox[name=checkedOne]:not(:checked)").each(function (index, check) {
						const del1 = check.parentElement.parentElement.lastElementChild.previousElementSibling.previousElementSibling;
						const del2 = check.parentElement.parentElement.lastElementChild.previousElementSibling.previousElementSibling.previousElementSibling;
						const del3 = check.parentElement.parentElement.lastElementChild.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling;
						
						del1.remove();
						del2.remove();
						del3.remove();
					});
					frm.submit();
				}
				else {
					alert('선택된 상품이 없습니다. 하나 이상의 상품을 선택해 주세요');
					e.preventDefault();
				}
			}
		}
	});
});

//총 상품금액 & 총 배송비 & 결제예정금액
window.addEventListener('load', (e) => {
	const totalPrice = [...document.querySelectorAll('.dCart-price')].map((price) => Number(price.innerHTML.replace(",", "")))
																	 .reduce((total, price) => total + price, 0);
	document.querySelector(".dTotalProductPrice").innerHTML = totalPrice.toLocaleString('ko-KR') + " 원";
	
	const seller = document.querySelectorAll("[name=seller]");
	const deliveryFee = document.querySelector(".dTotalDeliveryFee");
	let allSeller = new Set();
	
	seller.forEach((seller) => {
		allSeller.add(seller.value);
	})
	
	const totalDeliveryFee = allSeller.size * 3000;
	
	deliveryFee.innerHTML = totalDeliveryFee.toLocaleString('ko-KR') + " 원";
	
	const dTotalPrice = document.querySelector(".dTotalPrice");
	dTotalPrice.innerHTML = (totalPrice + totalDeliveryFee).toLocaleString('ko-KR') + " 원";
});

// 총금액 다시 계산하기
const totalCalc = () => {
	let totalCount = 0;
	let totalPrice = 0;
	document.querySelectorAll('.dCart-count').forEach((e) => {
		const count = parseInt(e.innerText);
		totalCount += count;
		const price = parseInt(e.parentElement.previousElementSibling.firstElementChild.lastElementChild.value);
		totalPrice += count * price;
	});
	
	document.querySelector(".dTotalProductPrice").innerHTML = totalPrice.toLocaleString('ko-KR') + " 원";
	
	const deliveryFee = parseInt(document.querySelector(".dTotalDeliveryFee").innerHTML.replace(",", ""));
	
	document.querySelector(".dTotalPrice").innerHTML = (totalPrice + deliveryFee).toLocaleString('ko-KR') + " 원";
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>