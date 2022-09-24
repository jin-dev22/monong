<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta charset="UTF-8">
<title>모농모농</title>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<!-- boot css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<!-- 모농모농css/js -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />

<%--  sockjs cdn 
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
--%>
<%-- stompjs cdn 
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
--%>

<sec:authorize access="isAuthenticated()">
	<script>
	const memberId = "<sec:authentication property='principal.username'/>";
	</script>
<script src="${pageContext.request.contextPath}/resources/js/ws.js"></script>
</sec:authorize>
<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
</c:if>

</head>
<body>

<body>
	<header id="header">
		<a href="${pageContext.request.contextPath}/" class="logo">
			<img src="${pageContext.request.contextPath}/resources/images/logo.PNG" alt="모농모농 로고이미지" />
		</a>
		<nav class="nav mainmenu">
			<a class="nav-link" href="#">&#128204;사이트소개</a>
			<a class="nav-link"	href="${pageContext.request.contextPath}/subscribe/subscribeMain.do">정기구독&#127822;</a>
			<a class="nav-link" href="${pageContext.request.contextPath}/direct/directProductList.do">직거래&#127805;</a>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a class="nav-link" href="${pageContext.request.contextPath}/admin/memberList.do">관리자페이지</a>
            </sec:authorize>
		</nav>
		
		  <sec:authorize access="isAnonymous()"> 
			<nav class="nav flex-column login">
				<nav class="nav justify-content-end">
					<a class="nav-link" href="#" onclick="alert('로그인 후 이용해 주세요.')">&#128722;</a>
				</nav>
				<nav class="nav justify-content-end">
					<a class="nav-link" href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
					<a class="nav-link" onclick="clickErollModal();">회원가입</a>
				</nav>
			</nav>
		 </sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<nav class="nav flex-column login">
				<nav class="nav justify-content-end">
				<sec:authorize access="!hasRole('ROLE_ADMIN')">
					<a class="nav-link" href="${pageContext.request.contextPath}/notification/memberNotificationList.do">&#128276;</a>
					
						<a class="nav-link" href="${pageContext.request.contextPath}/direct/cart.do">&#128722;</a>
                </sec:authorize>
				</nav>
				<nav class="nav justify-content-end">
					<p>
						<sec:authentication property="principal.username"/>님&#128149;
                	</p>
                	<sec:authorize access="hasRole('ROLE_MEMBER')">
						<a class="nav-link" href="${pageContext.request.contextPath}/member/memberSubscribeList.do">마이페이지</a>
                	</sec:authorize>
                	<sec:authorize access="hasRole('ROLE_SELLER')">
						<a class="nav-link" href="${pageContext.request.contextPath}/member/sellerProdList.do">마이페이지</a>
                	</sec:authorize>
                	<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a class="nav-link" href="${pageContext.request.contextPath}/member/memberCheckForm.do">관리자 정보</a>
                	</sec:authorize>
					<form:form action="${pageContext.request.contextPath}/member/memberLogout.do" method="POST" class="my-auto">
					  <button class="nav-link btn" type="submit">로그아웃</button>
					</form:form>
					
				</nav>
	  		</nav>
	  	</sec:authorize>
	</header>
	<div id="enrollType-modal-container"></div>
	<section id="content">