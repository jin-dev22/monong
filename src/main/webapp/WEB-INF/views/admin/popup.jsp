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
<title>주간채소공지</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<!-- boot css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<!-- 모농모농css/js -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/popup.css" />

</head>
<body>
<c:if test="${noticeWeekVegs eq null}">
	<div id="popup">
		<div class="popupWrapper">
			<div class="popup_title">
				<h1 class="popup_date"></h1>
				<img src="${pageContext.request.contextPath}/resources/images/logo.PNG" alt="모농모농 로고이미지" />
			</div>
			<div class="popup_content">
				<p>텅!</p>
				<p>빠른 시간내로 공지하겠습니다.</p>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${noticeWeekVegs ne null}">
<div id="popup">
	<div class="popupWrapper">
		<div class="popup_title">
			<h1 class="popup_date">${noticeWeekVegs.weekCriterion}</h1>
			<img src="${pageContext.request.contextPath}/resources/images/logo.PNG" alt="모농모농 로고이미지" />
		</div>
		<div class="popup_content">
			<span>&#128226;</span>
			<span>${noticeWeekVegs.vegComposition}</span>
			<span class="popup_notice">※제외 품목에 따라 구성이 달라질 수 있습니다. </span>
		</div>
	</div>
	
	
</div>
</c:if>
</body>
</html>