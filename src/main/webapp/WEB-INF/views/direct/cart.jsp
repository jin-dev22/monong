﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-장바구니" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/direct/direct.css" />
<h2 class="cart-title">장바구니</h2>
<div class="dCart_selected">
	<form name="CartFrm" method="POST" action="${pageContext.request.contextPath}/direct/cartToOrder.do">
		<h4>선택상품</h4>
		<div class="dCartProduct-info">
			<div class="dCartProduct-info-content">
				<input type="hidden" name="dOrderNo" value=""/>
				<input type="hidden" name="dOptionNo" value=""/>
				<div class="checkbox-container">
					<div class="checkbox-line">
						<label class="checkedAll" for="checkedAll">
							<input id="checkedAll" type="checkbox" />전체선택
						</label>
						<span class="checkbox-bar"></span>
						<button class="checkedDelete" type="button">선택삭제</button>
					</div>
					<button class="btn allClear btn-116530" >장바구니 비우기</button>
				</div>
				<ul class="dCart-info">
					<c:forEach items="${cartList}" var="cartList">
						<li class="cart-list">
							<label class="checkedOne" for="checkedOne">
<!-- 								<input id="checkedOne" type="checkbox" /> -->
							</label>
							<a href="${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=" class="dCart-img-container">
								<span class="dCart-img" style="background-image: url(${pageContext.request.contextPath}/resources/upload/product/${cartList.directProductAttachments[0].DProductRenamedFilename});"></span>
							</a>
							<div class="dCart-name-container">
								<a href="${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=" class="dCart-name">
									<p class="dCart-productName">${cartList.directProduct.DProductName}</p>
									<p class="dCart-optionName">[옵션] ${cartList.directProductOption.DOptionName}</p>
								</a>					
							</div>
							<div class="dCart-count-container">
								<button class="dCart-minus-btn" type="button">-</button>
								<div class="dCart-count">${cartList.productCount}</div>
								<button class="dCart-plus-btn" type="button">+</button>
							</div>
							<div class="dCart-price-container">
								<span class="dCart-price"><fmt:formatNumber pattern="#,###">${cartList.productCount * cartList.directProductOption.DPrice}</fmt:formatNumber>원</span>					
							</div>
							<button class="dCart-delete-btn" type="button">x</button>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="dCartProduct-pay-info">
			<table class="tbl-dCartProduct-pay">
				<thead>
					<tr>
						<th>총 상품금액</th>
						<th style="width: 30px;"></th>
						<th>총 배송비</th>
						<th style="width: 30px;"></th>
						<th>결제예정금액</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><span class="dTotalProductPrice"></span></td>
						<td style="width: 30px;"><img style="width: 30px;" alt="plus" src="${pageContext.request.contextPath}/resources/images/plus.png"></td>
						<td><span class="dDeliveryFee"></span></td>
						<td style="width: 30px;"><img style="width: 30px;" alt="equal" src="${pageContext.request.contextPath}/resources/images/equal.png"></td>
						<td><span class="dTotalPrice"></span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="dCartProduct-pay-btn">
			<button style="margin: 0 8px; font-size: 14px;" type="button" class="btn checkedAllOrder btn-EA5C2B">전체상품주문</button>
			<button style="margin: 0 2px; font-size: 14px;" type="button" class="btn checkedOrder btn-EA5C2B-reverse">선택상품주문</button>
		</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>