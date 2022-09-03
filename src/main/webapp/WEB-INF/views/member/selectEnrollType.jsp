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
	<button>일반회원 가입</button>
	<button>판매자회원 가입</button>
</div>

<script>
document.memberEnrollFrm.addEventListener('submit', (e) => {
	//아이디 체크
	if(idValid.value === "0"){
		e.preventDefault();
		alert("유효한 아이디를 입력해주세요.");
		return;
	}
	//동의여부 체크
	const agreeRequired = document.querySelectorAll('input[name="agreement-required"]');
	let cntChkd = 0;
	agreeRequired.forEach((checkbox)=>{
		if(!checkbox.checked){
			cntChkd++;
		}		
	});
	if(cntChkd > 0){
		e.preventDefault();
		alert("필수항목에 동의하지 않으면 회원가입이 불가능해요.");
	}
});

const ok = document.querySelector(".guide.ok");
const error = document.querySelector(".guide.error");
const idValid = document.querySelector("#idValid");

/*
 * 아이디 중복 체크
 */
document.querySelector("#memberId").addEventListener('keyup', (e) => {
	const {value : memberId} = e.target;
	console.log(memberId);	
	
	if(memberId.length < 4){
		idValid.value = "0";
		error.style.display = "none";
		ok.style.display = "none";
		return;
	}
	
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	console.log(headers);//값이 없음.
	
	$.ajax({
		url : "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
		method : "POST",
		headers, //나중에 시큐리티 관련 설정하면 주석해제하기.
		data : {memberId},
		success(response){
			console.log(response, typeof response); // js object
			
			const {available} = response;
			console.log(available);//xml mapper의존주석처리, 메세지컨버터의존활성화함 
			
			if(available){
				error.style.display = "none";
				ok.style.display = "inline";
				idValid.value = "1";
			}
			else {
				error.style.display = "inline";
				ok.style.display = "none";
				idValid.value = "0";
			}
			
		},
		error(jqxhr, statusText, err){
			console.log(jqxhr, statusText, err);
		}
	});
	
});

//email 중복 체크
document.querySelector("#memberEmail").addEventListener('keyup', (e) => {
	const {value : email} = e.target;
	console.log(email);	
	
	if(memberId.length < 4){
		idValid.value = "0";
		error.style.display = "none";
		ok.style.display = "none";
		return;
	}
	
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	console.log(headers);//값이 없음.
	
	$.ajax({
		url : "${pageContext.request.contextPath}/member/checkEmailDuplicate.do",
		method : "POST",
		headers, 
		data : {email},
		success(response){
			console.log(response, typeof response); // js object
			
			const {available} = response;
			console.log(available);//xml mapper의존주석처리, 메세지컨버터의존활성화함 
			
			if(available){
				error.style.display = "none";
				ok.style.display = "inline";
				idValid.value = "1";
			}
			else {
				error.style.display = "inline";
				ok.style.display = "none";
				idValid.value = "0";
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
/*//검색버튼?
document.querySelector("#bnt-srch").addEventListener('click', function(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            document.querySelector("#address").value = data.address;
            document.querySelector("#address-ex").focus();
        }
    }).open();
});
*/

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>