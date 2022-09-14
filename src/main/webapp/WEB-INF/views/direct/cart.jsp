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
	<form name="CartFrm" method="POST" action="${pageContext.request.contextPath}/direct/cart.do">
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
				</div>
				<ul class="dCart-info">
					<li class="cart-list">
						<label class="checkedOne" for="checkedOne">
							<input id="checkedOne" type="checkbox" />
						</label>
						<a class="dCart-img-container">
							<span class="dCart-img"></span>
						</a>
						<div class="dCart-name-container">
							<a class="dCart-name">
								<p class="dCart-productName">상품명</p>
								<p class="dCart-optionName">[옵션] 옵션명</p>
							</a>					
							<div></div>
						</div>
						<div class="dCart-count-container">
							<button class="dCart-minus-btn" type="button">-</button>
							<div class="dCart-count">1</div>
							<button class="dCart-plus-btn" type="button">+</button>
						</div>
						<div class="dCart-price-container">
							<span class="dCart-price">29,900원</span>					
						</div>
						<button class="dCart-delete-btn" type="button">x</button>
					</li>
				</ul>
			</div>
		</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>