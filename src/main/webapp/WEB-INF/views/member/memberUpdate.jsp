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

<div id="member-update-container" class="mx-auto mt-10 text-center">
<h1>회원정보 수정</h1>
	<form:form name="memberUpdateFrm" 
			   action="${pageContext.request.contextPath}/member/memberUpdate.do" 
			   method="post"
			   id="memberUpdateFrm">

		
		<label for="memberId">아이디</label>
		<input type="text" class="w3-input my-3" placeholder="아이디 (4글자이상)" name="memberId" id="memberId" value='<sec:authentication property="principal.username"/>'readonly required/>
		<br />

		<label for="name">이름</label>
		<input type="text" class="w3-input my-3" placeholder="이름" name="memberName" id="name" value='<sec:authentication property="principal.memberName"/>'required/>
		<br />
		
		<label for="birthday">생일</label>
		<input type="date" class="w3-input my-3" placeholder="생일" name="memberBirthday" id="birthday" value='<sec:authentication property="principal.memberBirthday"/>'/>
		<br />
		<label for="email">이메일</label>
		<input type="email" class="w3-input my-3" placeholder="이메일" name="memberEmail" id="email" value='<sec:authentication property="principal.memberEmail"/>'/>
		<br />
		<label for="phone">연락처</label>
		<input type="tel" class="w3-input my-3" placeholder="전화번호 (예:01012345678)" name="memberPhone" id="phone" maxlength="11" value='<sec:authentication property="principal.memberPhone"/>'required/>
		<br />
		<label for="address">주소</label>
		<input type="text" class="w3-input my-3" placeholder="주소" name="memberAddress" id="address" value='<sec:authentication property="principal.memberAddress"/>'/>
		
		<br /><br /><br />
		<input type="submit" class="btn btn-EA5C2B-reverse" value="수정" >&nbsp;
		<input type="reset" class="btn btn-outline-success" value="취소">
		
	</form:form>
	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>