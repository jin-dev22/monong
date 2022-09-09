<%@page import="com.kh.monong.member.model.dto.Member"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-마이페이지"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
<div id="member-mypage-container" class="mx-auto mt-10 text-center">
	<h2><strong><sec:authentication property="principal.memberName"/></strong>님</h2>
	<nav class="nav justify-content-end">
		<a class="nav-link" href="${pageContext.request.contextPath}/member/memberCheckForm.do">내 정보 관리</a>
	</nav>
	<div id="mypage-sellerInfo-container">
		<div><span class="seller-info-label">사업자등록번호 : </span> ${seller.sellerInfo.sellerRegNo}</div>
		<div><span class="seller-info-label">대표자명 : </span>${seller.sellerInfo.sellerName}</div>
		<div><span class="seller-info-label">사업장 주소 : </span><sec:authentication property="principal.memberAddress"/><sec:authentication property="principal.memberAddressEx"/></div>
		<div><span class="seller-info-label">이메일 : </span><sec:authentication property="principal.memberEmail"/></div>
		<div><span class="seller-info-label">전화번호 : </span><span id="phoneNumber"></span></div>
	</div>
	<script>
	const phoneNumber = document.querySelector("#phoneNumber");
	const memberPhone = `${seller.memberPhone}`;
	const setPhoneNumber = (phone, elem) =>{
		elem.innerHTML = phone.replace(/(^02.{0}|^01.{1}|^07.{}1|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	};
	setPhoneNumber(memberPhone, phoneNumber)
	</script>
</div>
	<nav class="nav justify-content-around mt-5">
		<a href="#">판매목록</a>
		<a href="#">상품문의</a>
		<a href="#">관리자 문의</a>
	</nav>

<hr />
<div id="seller-productList">
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>