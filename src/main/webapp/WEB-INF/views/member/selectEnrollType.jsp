<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-회원가입"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member.css" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
div#enroll-container table th{
	width: 150px;
}
</style>

<div id="enroll-container" class="mx-auto text-center">
	<div><a href="${pageContext.request.contextPath}/member/memberEnroll.do">일반회원 가입</a></div>
	<div><a href="${pageContext.request.contextPath}/member/sellerEnroll.do">판매자회원 가입</a></div>	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>