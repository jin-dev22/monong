<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-비밀번호 변경"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<div id="login-searchPw-container" class="mx-auto mt-10">
	<div class="mb-5 text-center">
		<h1>비밀번호 변경</h1>
		<span>현재 비밀번호와 새 비밀번호를 입력해주세요</span>
	</div>
	
	<form:form name="findIdFrm" 
			  action="${pageContext.request.contextPath}/member/memberPwUpdate.do" 
			  method="post">
		<input type="hidden" name="memberId" id="memberId" value='<sec:authentication property="principal.username"/>'/>
		<div class="row mb-3 col-md-13 justify-content-center">
			<div class="mb-2 col-sm-9">
				<label for="oldPassword">현재 비밀번호</label>
				<input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="현재 비밀번호" required/>
			</div>
		</div>
		
		<div class="row mb-3 col-md-13 justify-content-center">
			<div class="mb-2 col-sm-9">
				<label for="newPassword">새 비밀번호</label>
				<input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="" required/>
				<span class="invalid-feedback feedback-password">6자리 이상 작성해주시기 바랍니다.</span>
			</div>
		</div>
		
		<div class="row mb-3 col-md-13 justify-content-center">
			<div class="mb-2 col-sm-9">
				<label for="newPasswordChk">새 비밀번호 확인</label>
				<input type="password" class="form-control" id="newPasswordChk" name="newPasswordChk" placeholder="새 비밀번호 확인" required/>
				<span class="invalid-feedback feedback-password">비밀번호가 일치하지 않습니다.</span>
			</div>
		</div>
		
		<div class="row mb-3 col-md-13 justify-content-center">
			<button type="submit" id="findId-btn" class="btn btn-EA5C2B">변경</button>
		</div>
	</form:form>
</div>
<script>
const invalidPwdFeedbacks = document.querySelectorAll(".invalid-feedback.feedback-password");
document.querySelector("#newPassword").addEventListener('blur', (e)=>{
	const password = e.target;
	const regExp = /^[a-zA-z0-9]{6,}$/;
	
	if(!regExp.test(password.value)){
		invalidPwdFeedbacks[0].style.display = "inline";
		password.value = "";
	}
	else{
		invalidPwdFeedbacks[0].style.display = "none";
	}	
});

document.querySelector("#newPasswordChk").addEventListener("blur", (e)=>{
	const passwordChk = e.target;
	const password = document.querySelector("#newPassword");
	if(passwordChk.value !== password.value){
		invalidPwdFeedbacks[1].style.display = "inline";
		passwordChk.value = "";
	}
	else{
		invalidPwdFeedbacks[1].style.display = "none";
	}
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>