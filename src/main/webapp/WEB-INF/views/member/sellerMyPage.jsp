<%@page import="com.kh.monong.member.model.dto.Member"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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
		<div><span class="seller-info-label">사업자등록번호 : </span><sec:authentication property="principal.sellerInfo.sellerRegNo"/></div>
		<div><span class="seller-info-label">대표자명 : </span><sec:authentication property="principal.sellerInfo.sellerName"/></div>
		<div><span class="seller-info-label">사업장 주소 : </span><sec:authentication property="principal.memberAddress"/><sec:authentication property="principal.memberAddressEx"/></div>
		<div><span class="seller-info-label">이메일 : </span><sec:authentication property="principal.memberEmail"/></div>
		<div><span class="seller-info-label">전화번호 : </span><span id="phoneNumber"><sec:authentication property="principal.memberPhone"/></span></div>
	</div>
	<script>
	const phoneNumber = document.querySelector("#phoneNumber");
	const setPhoneNumber = (phone, elem) =>{
		elem.innerHTML = phone.replace(/(^02.{0}|^01.{1}|^07.{}1|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	};
	setPhoneNumber(phoneNumber.innerHTML, phoneNumber);
	</script>
	<nav class="nav justify-content-around mt-5">
		<a href="${pageContext.request.contextPath}/member/sellerProdList.do">판매상품목록</a>
		<a href="${pageContext.request.contextPath}/member/sellerDirectOrderList.do">주문내역관리</a>
		<a href="${pageContext.request.contextPath}/member/sellerProductQnAList.do">상품문의</a>
		<a href="${pageContext.request.contextPath}/member/memberInquireList.do">관리자 문의</a>
	</nav>
</div>

<hr />