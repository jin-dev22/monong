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
<div id="member-update-container" class="mx-auto mt-10">
	<div class="mb-3 text-center">
		<h1>회원정보수정</h1>
		<h1>판매자!!!</h1>
	</div>	
	<nav class="nav justify-content-end">
		<a class="nav-link" href="${pageContext.request.contextPath}/member/memberPwUpdate.do"><h5>비밀번호 변경</h5></a>
	</nav>
	<form:form name="memberUpdateFrm" 
			   action="${pageContext.request.contextPath}/member/memberUpdate.do" 
			   method="post"
			   id="memberUpdateFrm">

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="memberId">아이디</label>
				<input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="memberId" id="memberId" value='<sec:authentication property="principal.username"/>'readonly required/>
				<br />
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="name">이름</label>
				<input type="text" class="form-control" placeholder="이름" name="memberName" id="name" value='<sec:authentication property="principal.memberName"/>'required/>
				<br />
			</div>
		</div>
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="email">이메일</label>
				<input type="email" class="form-control" placeholder="이메일" name="memberEmail" id="email" value='<sec:authentication property="principal.memberEmail"/>'/>
				<br />
			</div>
		</div>
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="phone">연락처</label>
				<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="memberPhone" id="phone" maxlength="11" value='<sec:authentication property="principal.memberPhone"/>'required/>
				<br />
			</div>
		</div>
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="address">주소</label>
				<input type="text" class="form-control" placeholder="주소" name="memberAddress" id="address" value='<sec:authentication property="principal.memberAddress"/>'/>
				<br />
			</div>
		</div>
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">	
				<label for="birthday">생일</label>
				<input type="date" class="form-control" placeholder="생일" name="memberBirthday" id="birthday" value='<sec:authentication property="principal.memberBirthday"/>'/>
				<br />
			</div>
		</div>
		
		<br />
		<div class="mb-3 text-center">
			<input type="submit" class="btn btn-EA5C2B-reverse" value="수정" >&nbsp;
			<input type="reset" class="btn btn-outline-success" value="취소">
		</div>
	</form:form>
	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>