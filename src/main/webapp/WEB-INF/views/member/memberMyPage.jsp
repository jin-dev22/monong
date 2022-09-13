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
<div id="member-mypage-container" class="mx-auto mt-10 text-center">
<h2><strong><sec:authentication property="principal.memberName"/></strong>님</h2>
<nav class="nav justify-content-end">
	<a class="nav-link" href="${pageContext.request.contextPath}/member/memberCheckForm.do">내 정보 관리</a>
</nav>
<div id="mypage-subcribe-container">
	<!-- 구독중인 플랜이 없을 때 -->
	<h3>구독중인 플랜이 없어요</h3>
	
	<button id="mypage-subscribe-btn" type="button" class="btn btn-EA5C2B-reverse">구독신청</button>
	<!-- 구독중인 플랜이 있을 때 -->
	<h5>정기구독</h5>
	<table id="member-subscribe-tbl" class="table table-bordered table-striped text-center">
	<thead>
	  <tr>
	    <td class="tg-0pky" rowspan="3">사진</td>
	    <td class="tg-0pky">정기구독 제품명</td>
	    <td class="tg-0pky">상품금액</td>
	  </tr>
	  <tr>
	    <td class="tg-0lax">배송주기</td>
	    <td class="tg-0lax"></td>
	  </tr>
	  <tr>
	    <td class="tg-0lax"></td>
	    <td class="tg-0lax"><button id="mypage-subscribe-btn" type="button" class="btn btn-EA5C2B">구독관리</button></td>
	  </tr>
	</thead>
	</table>
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
