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
	<jsp:param name="title" value="모농모농-관리자페이지"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/admin.css" />
<div id="admin-mypage-container" class="mx-auto mt-10 text-center">

<div id="admin-member-container" class="mx-auto row justify-content-around">
	<a class="col-3" href="${pageContext.request.contextPath}/admin/memberList.do">일반회원</a>
	<a class="col-3"href="${pageContext.request.contextPath}/admin/sellerList.do">판매자회원</a>
</div>

<nav class="nav justify-content-around mt-5">
	<a href="${pageContext.request.contextPath}/member/memberOrderList.do">정기구독</a>
	<a href="${pageContext.request.contextPath}/member/memberReviewList.do">직거래</a>
	<a href="${pageContext.request.contextPath}/member/memberDirectInquire.do">1:1문의</a>
	<a href="${pageContext.request.contextPath}/member/memberInquireList.do">주간채소</a>
</nav>

</div>

<hr />
<script>

</script>
