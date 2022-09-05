<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-로그인"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<div id="login-container" class="mx-auto mt-10 text-center">
	<div>
		<h1>로그인</h1>
	</div>

		<form:form name="memberLoginFrm" 
			  action="${pageContext.request.contextPath}/member/memberLogin.do" 
			  method="POST">
			 <c:if test="${param.error != null}">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
				아이디 또는 비밀번호가 일치하지 않습니다.
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">×</span>
				</button>
				</div>
			</c:if>
			<div class="row mb-3 mt-5">
				<label for="loginMemberIdInput" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10">
				<input type="text" name="memberId" class="form-control" id="loginMemberIdInput" placeholder="아이디를 입력해주세요"/>
				</div>
			</div>
			<div class="row mb-3">
				<label for="loginMemberPwInput" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-10">
				<input type="password" name="memberPassword" class="form-control" id="loginMemberPwInput" placeholder="비밀번호를 입력해주세요"/>
				</div>
			</div>
			<div>
				<input type="checkbox" name="remember-me" id="remember-me" class="form-check-input" />
				<label for="remember-me" class="form-check-label">로그인 유지</label>
			</div>
			<div class="mt-5 mb-3">
				<button type="submit" class="btn btn-EA5C2B">로그인</button>
			</div>
		</form:form>
		<button type="button" class="btn btn-116530" onclick="location.href='${pageContext.request.contextPath}/member/selectEnrollType.do';">회원가입</button>
		<button type="button" class="btn btn-EA5C2B-reverse" onclick="location.href='${pageContext.request.contextPath}/member/memberIdSearchForm.do';">아이디찾기</button>
		<button type="button" class="btn btn-EA5C2B-reverse" onclick="location.href='${pageContext.request.contextPath}/member/memberPwSearchForm.do';">비밀번호찾기</button>
		</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>