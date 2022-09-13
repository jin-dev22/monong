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
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<div id="member-mypage-container" class="mx-auto mt-10">

<nav id="member-mypage-nav"class="nav justify-content-around">
	<h2><strong><sec:authentication property="principal.memberName"/></strong>&nbsp;님</h2>
	<h5><a class="nav-link" href="${pageContext.request.contextPath}/member/memberCheckForm.do"><strong>내 정보 관리</strong></a></h5>
</nav>
<div id="mypage-subcribe-container">
	<!-- 구독중인 플랜이 없을 때 -->
	<c:if test="${recentSubOrder == null}">
		<h3>구독중인 플랜이 없어요 :( </h3>
		<button id="mypage-subscribe-btn" type="button" class="btn btn-EA5C2B-reverse" onclick="location.href='${pageContext.request.contextPath}/subscribe/subscribeMain.do';">구독신청</button>
	</c:if>
	<!-- 구독중인 플랜이 있을 때 -->
	<c:if test="${recentSubOrder != null}">
		<div class="text-left">
			<h2><strong>정기 구독</strong></h2>
		</div>
		<br />
		<table id="member-subscribe-tbl" class="table table-borderless text-center">
		<colgroup>
			<col style="width: 300px">
			<col style="width: 300px">
			<col style="width: 300px">
		</colgroup>
		<thead>
		  <tr>
		    <td rowspan="3">
				<c:if test="${recentSubOrder.subscription.SProductCode eq 'SP1'}">
					<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg" alt="싱글 이미지">
				</c:if>
				<c:if test="${recentSubOrder.subscription.SProductCode eq 'SP2'}">
					<img src="${pageContext.request.contextPath}/resources/images/subscribe/레귤러.jpg" alt="레귤러 이미지">
				</c:if>
				<c:if test="${recentSubOrder.subscription.SProductCode eq 'SP3'}">
					<img src="${pageContext.request.contextPath}/resources/images/subscribe/라지.jpg" alt="라지 이미지">
				</c:if>
			</td>
		    <td><h4>${recentSubProduct.SProductName}&nbsp;&nbsp;&nbsp;${recentSubProduct.SProductInfo}</h4></td>
		    <td><h4>${recentSubOrder.SPrice} 원</h4></td>
		  </tr>
		  <tr>
		    <td><h4>배송주기: ${recentSubOrder.subscription.SDeliveryCycle}주</h4></td>
		    <td></td>
		  </tr>
		  <tr>
		    <td></td>
		    <td><button id="mypage-subscribe-btn" type="button" class="btn btn-EA5C2B" onclick="location.href='${pageContext.request.contextPath}/member/memberSubscribeOrder.do';">구독관리</button></td>
		  </tr>
		</thead>
		</table>
	</c:if>
</div>
<nav class="nav justify-content-around mt-5">
	<a href="${pageContext.request.contextPath}/member/memberOrderList.do">주문내역</a>
	<a href="${pageContext.request.contextPath}/member/memberReviewList.do">작성후기</a>
	<a href="${pageContext.request.contextPath}/member/memberDirectInquire.do">상품문의</a>
	<a href="${pageContext.request.contextPath}/member/memberInquireList.do">관리자 문의</a>
</nav>
</div>
<hr />
<script>

</script>
