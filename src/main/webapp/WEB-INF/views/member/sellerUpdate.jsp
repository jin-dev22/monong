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
<style>
	.sellerUpdate-fitInput{
		width: 100%;
	}
	 #sellerUpdate-attachUpdate-container{
		display: flex;
		justify-content: space-between;
		align-items: center;
	} 
	
	#sellerUpdate-btn-download{
		min-width: 200;
		overflow: hidden;
	}
	#btn-email-sendKey{
		margin-top: 10px;
		float: right;
	}
	
</style>
<div id="member-update-container" class="mx-auto mt-10">
	<div class="mb-3 text-center">
		<h1>회원정보수정</h1>
	</div>
	<nav class="nav justify-content-end">
		<a class="nav-link" href="${pageContext.request.contextPath}/member/memberPwUpdate.do">
			<h5>비밀번호 변경</h5>
		</a>
	</nav>
	<form name="memberUpdateFrm" id="memberUpdateFrm"
		action="${pageContext.request.contextPath}/member/sellerUpdate.do"
		method="POST" accept-charset="UTF-8" enctype="multipart/form-data">
		
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="memberId">아이디</label> 
				<input type="text" name="memberId" class="form-control" id="memberId"
					value="<sec:authentication property="principal.username"/>" readonly required>
			</div>
		</div>
		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="name">업체명<span class="enroll-form-required">*</span></label>
				<input type="text" name="memberName" class="form-control" id="memberName"
					value="<sec:authentication property="principal.memberName"/>" required>
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="name">대표자명<span class="enroll-form-required">*</span></label>
				<input type="text" name="sellerName" class="form-control" id="sellerName"
					value="<sec:authentication property="principal.sellerInfo.sellerName"/>" required>
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="memberPhone">전화번호<span class="enroll-form-required">*</span></label> 
				<input type="tel" name="memberPhone" class="form-control" id="memberPhone" 
					placeholder="(-없이)01012345678" maxlength="11"
					value='<sec:authentication property="principal.memberPhone"/>' required />
					<span class="invalid-feedback feedback-phone">띄어쓰기없이	번호만 입력해주세요.</span>
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="memberEmail">이메일<span class="enroll-form-required">*</span></label> 
				<span id="memberEmail-container"> 
					<input type="email" name="memberEmail" class="form-control" id="memberEmail"
					placeholder="abc@xyz.com"
					value='<sec:authentication property="principal.memberEmail"/>' required> 
					<span class="valid-feedback feedback-email">사용가능한 이메일입니다.</span> 
					<span class="invalid-feedback feedback-email">이미 사용중이거나 유효하지 않은 이메일형식입니다.</span> 
					<input type="hidden" id="emailValid" value="1" /><!-- 사용불가 0, 사용가능 1 -->
				</span> 
				<input type="button" class="enroll-info-btn btn btn-outline-success" id="btn-email-sendKey" value="이메일 인증" 
							disabled /><!-- 완성후 기능 살려놓기 -->
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<input type="text" id="emailKey" placeholder="인증코드를 입력하세요." required
							readonly /><!-- 프로젝트 완성 후 readolny해제 -->
				<input type="hidden" id="emailKeyValid" value="1" /><!-- 불일치 0, 일치 1 -->
				<input type="button" class="enroll-info-btn btn btn-outline-success" id="btn-email-enterKey" value="확인" 
							disabled /><!-- 프로젝트 완성 후 disabled해제 -->
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="memberAddress">주소<span class="enroll-form-required">*</span></label> 
				<input type="text" name="memberAddress" class="form-control" id="address"
					value="<sec:authentication property='principal.memberAddress'/>" readonly required>
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="address-ex">상세주소</label> 
				<input type="text" name="memberAddressEx" class="form-control" id="address-ex"
					value='<sec:authentication property="principal.memberAddressEx"/>'>
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="birthday">사업개시일<span class="enroll-form-required">*</span></label> 
				<input type="date" name="memberBirthday" class="form-control" id="birthday" 
					placeholder="사업개시일" 
					value='<sec:authentication property="principal.memberBirthday"/>' />
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="sellerRegNo">사업자등록번호<span class="enroll-form-required">*</span></label> 
				<input type="text" name="sellerRegNo" class="sellerUpdate-fitInput" id="sellerRegNo"
					placeholder="000-00-00000"
					value='<sec:authentication property="principal.sellerInfo.sellerRegNo"/>' required /> 
					<span class="invalid-feedback feedback-regNo">-를 포함하여 작성해주세요.</span>
			</div>
		</div>

		<div class="row mb-2 col-md-13 justify-content-center">
			<div class="col-sm-9">
				<label for="sellerRegFile">사업자등록증<span class="enroll-form-required">*</span></label> 
				<input type="file" name="sellerRegFile" class="sellerUpdate-fitInput" id="sellerRegFile" required /> 
				<label for="sellerUpdate-btn-download">기존파일</label>
				<div id="sellerUpdate-attachUpdate-container">
					<input type="button" class="btn btn-outline-success" id="sellerUpdate-btn-download"
						onclick="location.href='${pageContext.request.contextPath}/board/fileDownload.do?no=<sec:authentication property='principal.attachment.sellerAttachNo'/>';"
						value="<sec:authentication property='principal.attachment.originalFilename'/>" />
					&nbsp;&nbsp; 
					<label class="btn btn-outline-danger" title="삭제"> 
						<input type="checkbox" name="delFile" class="btn btn-outline-danger" id="delFile"
							value="<sec:authentication property='principal.attachment.sellerAttachNo'/>">
						삭제
					</label>
				</div>
			</div>
		</div>


		<sec:csrfInput />
		<br />
		<div class="mb-3 text-center sellerUpdate-submitBtn-container">
			<input type="submit" class="btn btn-EA5C2B-reverse" value="수정">&nbsp;
			<input type="reset" class="btn btn-outline-success" value="취소">
		</div>
	</form>
</div>
<script>
const emailValid = document.querySelector("#emailValid");
const emailKeyValid = document.querySelector("#emailKeyValid");

/**
 * 제출 전 입력값 valid확인
 */
document.memberUpdateFrm.addEventListener('submit', (e) => {	
	if(emailValid.value === "0"){
		e.preventDefault();
		alert("유효한 이메일을 입력해주세요.");
		return;
	}
	
	//이메일 인증
	/*테스트용 가입처리시 인증 불가능. 전체 사이트 완성 후 주석풀기
	if(emailKeyValid === "0"){
		e.preventDefault();
		alert("이메일 인증코드를 확인해주세요.");
		return;
	}
	*/
});

/**
 * 전화번호 자릿수
 */
const invalidPhoneFeedback = document.querySelector(".invalid-feedback.feedback-phone");
document.querySelector("#memberPhone").addEventListener("blur", (e)=>{
	const phone = e.target;
	const regExp = /^[0-9]{9,12}$/;
	
	if(!regExp.test(phone.value)){
		invalidPhoneFeedback.style.display = "inline";
		phone.value = "";
	}
	else{
		invalidPhoneFeedback.style.display = "none";
	}
});

/**
 * email 유효성, 중복
 */
const rememberEmail = document.querySelector("#memberEmail").value;

document.querySelector("#memberEmail").addEventListener('keyup', (e) => {
const validEmailFeedBack = document.querySelector(".valid-feedback.feedback-email");
const invalidEmailFeedBack = document.querySelector(".invalid-feedback.feedback-email");

	//기존 이메일을 수정했을 경우 유효성 검사를 위해 0으로 변경
	emailValid.value = "0";
	
	const {value : email} = e.target;
	console.log(email);	

	if(email.length < 7){
		emailValid.value = "0";
		invalidEmailFeedBack.style.display = "none";
		validEmailFeedBack.style.display = "none";
		return;
	}
	//post요청 전 기존 이메일 다시 입력시 검사하지 않고 리턴 
	if(rememberEmail === email){
		emailValid.value = "1";
		return;
	}
	
	const regExp = /^[\w\d]{4,}@[\w]+(\.[\w]+){1,3}$/;	
	
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	console.log(headers);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/member/checkEmailDuplicate.do",
		method : "POST",
		headers, 
		data : {email},
		success(response){
			const {available} = response;
			console.log(available);//xml mapper의존주석처리, 메세지컨버터의존활성화함 
			
			if(available && regExp.test(email)){
				invalidEmailFeedBack.style.display = "none";
				validEmailFeedBack.style.display = "inline";
				emailValid.value = "1";
			}
			else {
				invalidEmailFeedBack.style.display = "inline";
				validEmailFeedBack.style.display = "none";
				emailValid.value = "0";
			}
			
		},
		error(jqxhr, statusText, err){
			console.log(jqxhr, statusText, err);
		}
	});
	
});

//주소입력 라이브러리
document.querySelector("#address").addEventListener('click', function(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            document.querySelector("#address").value = data.address;
            document.querySelector("#address-ex").focus();
        }
    }).open();
});  

//이메일 인증코드 전송
document.querySelector("#btn-email-sendKey").addEventListener('click', (e)=>{
	if(emailValid.value == "0"){
		alert("유효한 이메일을 입력해주세요.");
		return;
	}
	
	//인증코드 전송 클릭시 입력된 이메일value 가져오기
	const newEmail = document.querySelector("#memberEmail").value;
	if(rememberEmail == newEmail){
		alert("이미 인증된 이메일입니다.");
		return;
	}
	
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	console.log(headers);
	
	const email = document.querySelector("#memberEmail").value;
	console.log(email);
	$.ajax({
		url : "${pageContext.request.contextPath}/member/sendEmailKey.do",
		method : "POST",
		headers, 
		data : {email},
		success(response){
			const {msg} = response;
			alert(msg);
			
		},
		error(jqxhr, statusText, err){
			console.log(jqxhr, statusText, err);
		}
	});
	
});

//인증코드 확인
document.querySelector("#btn-email-enterKey").addEventListener("click", (e)=>{
	const emailKey = document.querySelector("#emailKey");
	const email = document.querySelector("#memberEmail");
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	$.ajax({
		url : "${pageContext.request.contextPath}/member/checkEmailKey.do",
		method : "POST",
		headers,
		data : {"email" : email.value, "emailKey" : emailKey.value},
		success(response){
			const {isIdentified, msg} = response;
			if(isIdentified){
				emailKeyValid.value = "1";
				e.disabled = true;
				email.readOnly = true;
				emailKey.readOnly = true;	
			}
			alert(msg);
		},
		error(jqxhr, statusText, err){
			console.log(jqxhr, statusText, err);
		}		
	});
});


//사업자등록번호 유효성
const invalidRegNoFeedback = document.querySelector(".invalid-feedback.feedback-regNo");
document.querySelector("#sellerRegNo").addEventListener("blur", (e)=>{
	const regNo = e.target;
	const regExp = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
	
	if(!regExp.test(regNo.value)){
		invalidRegNoFeedback.style.display = "inline";
		//regNo.value = "";
		regNo.select();
	}
	else{
		invalidRegNoFeedback.style.display = "none";
	}	
});
</script>  
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>