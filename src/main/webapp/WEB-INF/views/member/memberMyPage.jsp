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
	<!-- 구독중인 플랜이 없거나, 다음 배송일이 없을 때 -->
	<c:if test="${recentSubscription == null || recentSubscription.SNextDeliveryDate eq null}">
		<h3>구독중인 플랜이 없어요 :( </h3>
		<button id="mypage-subscribe-btn" type="button" class="btn btn-EA5C2B-reverse" onclick="location.href='${pageContext.request.contextPath}/subscribe/subscribeMain.do';">구독신청</button>
	</c:if>
	<!-- 구독중인 플랜이 있을 때 -->
	<c:if test="${recentSubscription != null}">
		<div class="text-left">
			<h2>
				<strong>정기 구독</strong>
			</h2>
		</div>
		<br />
		<table id="member-subscribe-tbl" class="table table-borderless text-justify">
		<thead>
		  <tr>
		    <td rowspan="4">
				<c:if test="${recentSubscription.SProductCode eq 'SP1'}">
					<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg" alt="싱글 이미지">
				</c:if>
				<c:if test="${recentSubscription.SProductCode eq 'SP2'}">
					<img src="${pageContext.request.contextPath}/resources/images/subscribe/레귤러.jpg" alt="레귤러 이미지">
				</c:if>
				<c:if test="${recentSubscription.SProductCode eq 'SP3'}">
					<img src="${pageContext.request.contextPath}/resources/images/subscribe/라지.jpg" alt="라지 이미지">
				</c:if>
			</td>
		    <td colspan="2"><h4>다음 결제일: ${recentSubscription.SPaymentDate} </h4></td>
		  </tr>
		  <tr>
		  	<td><h4>${recentSubProduct.SProductName}&nbsp;&nbsp;&nbsp;${recentSubProduct.SProductInfo}</h4></td>
		    <td><h4>배송주기: ${recentSubscription.SDeliveryCycle}주</h4></td>
		  </tr>
		  <tr>
		    <td colspan="2">
		    	<h4>제외채소 : ${recentSubscription.SExcludeVegs != null ? recentSubscription.SExcludeVegs : '없음'}</h4>
		    </td>
		  </tr>
		  <tr>
		  	<td></td>
		  	<td style="text-align: right;">
		    	<button id="mypage-subscribe-btn" type="button" class="btn btn-EA5C2B" onclick="location.href='${pageContext.request.contextPath}/member/memberSubscribeOrder.do';">구독관리</button>
		    </td>
		  </tr>
		</thead>
		</table>
	</c:if>
</div>
 

	<div class="container">
      <ul class="nav justify-content-around bg-light">
      	<li class="nav-item">
			<a class="nav-link" id="lnik-sOList" href="${pageContext.request.contextPath}/member/memberSubscribeList.do">구독내역</a>
		</li>
		
		<li class="nav-item">	
			<a class="nav-link" id="lnik-dOList" href="${pageContext.request.contextPath}/member/memberDirectList.do">직거래주문내역</a>
		</li>
		
		<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            작성후기
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" id="lnik-dReviewEnrollList" href="${pageContext.request.contextPath}/member/memberDirectReviewEnrollList.do">직거래작성가능후기</a></li>
            <li><a class="dropdown-item" id="lnik-dReviewList" href="${pageContext.request.contextPath}/member/memberDirectReviewList.do">직거래작성완료후기</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" id="lnik-sReviewList" href="${pageContext.request.contextPath}/member/memberSubscribeReviewList.do">구독작성후기</a></li>
          </ul>
		</li>
		
		<li class="nav-item">
			<a class="nav-link" id="lnik-dInqList" href="${pageContext.request.contextPath}/member/memberDirectInquireList.do">상품문의내역</a>
		</li>
		
		<li class="nav-item">
			<a class="nav-link" id="lnik-inqList" href="${pageContext.request.contextPath}/member/memberInquireList.do">관리자 문의</a>
		</li>
		
		</ul>
	</div>


</div>
<hr />

