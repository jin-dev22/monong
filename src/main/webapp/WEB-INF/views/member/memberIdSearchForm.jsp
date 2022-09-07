<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농-아이디찾기"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/member.css" />
<div id="login-searchform-container" class="mx-auto mt-10">
	<div class="mb-5 text-center">
		<h1>아이디 찾기</h1>
		<span>가입하신 이메일로 아이디를 발송해드립니다.</span>
	</div>

		<form:form name="findIdFrm" 
			  action="${pageContext.request.contextPath}/member/memberIdSearchForm.do" 
			  method="post">
			<div class="row mb-2 col-md-13 justify-content-center">
				<div class="mb-2 col-sm-9">
				<label for="name">이름</label>
				<input type="text" class="w3-input my-2" id="name" name="name" placeholder="이름을 입력해주세요" required />	
				</div>
			</div>
			
			<div class="row mb-5 col-md-13 justify-content-center">
				<div class="mb-2 col-sm-9">
				<label for="email">이메일</label>
				<input type="text" class="w3-input" id="email" name="email" placeholder="ex) monong@gmail.com" required/>
				</div>
			</div>
			
			<div class="row mb-3 col-md-13 justify-content-center">
				<button type="submit" id="findId-btn" class="btn btn-EA5C2B">확인</button>
			</div>
		</form:form>
		
	</div>
<script>
const targetBtn = document.querySelector('#findId-btn');
const nameInput = document.querySelector("#name");
const emailInput = document.querySelector("#email");

targetBtn.disabled = true;

/**
 * 필수입력값 유효하게 작성했을 때만 버튼 활성화
 */
const isActiveLogin = () => {
	  let nameVal = nameInput.value;
	  let emailVal = emailInput.value;
	  const re = /\w+@\w+\.\w+/g;

	  if(
	      (nameVal && emailVal) && 
	      (nameVal.length >= 2) && 
	      	re.test(emailVal)
	      ) {
		  targetBtn.disabled = false;
		  targetBtn.style.opacity = 1;
		  targetBtn.style.cursor = 'pointer';
	  }
	  else {
		  targetBtn.disabled = true;
		  targetBtn.style.opacity = .3;
		  
	  }
	}

const init = () => {
	  nameInput.addEventListener('input', isActiveLogin);
	  emailInput.addEventListener('input', isActiveLogin);
	  nameInput.addEventListener('keyup', isActiveLogin);
	  emailInput.addEventListener('keyup', isActiveLogin);
	}

	init();




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>