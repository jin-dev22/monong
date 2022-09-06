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
	<jsp:param name="title" value="모농모농-회원정보수정"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<div id="member-check-container" class="mx-auto mt-10 text-center">
<h1>비밀번호 재확인</h1>
<span>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요</span>

<form:form name="memberCheckFrm"
		action="${pageContext.request.contextPath}/member/memberCheckForm.do"
		method="post"
		id="memberCheckFrm">
		
		<label for="memberId">아이디</label>
		<input type="text" class="w3-input my-3" name="memberId" id="memberId" value='<sec:authentication property="principal.username"/>'readonly required/>
		<br />
		<label for="memberPassword">비밀번호</label>
		<input type="password" class="w3-input my-3" name="memberPassword" id="memberPassword" placeholder="현재 비밀번호를 입력해주세요" required/>

		<br /><br /><br />
		<input type="submit" class="btn btn-EA5C2B-reverse" value="확인" >&nbsp;
</form:form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>