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
	<form name="memberEnrollFrm" action="" method="POST">
		<table class="mx-auto">
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
			            <input type="text" class="form-control" placeholder="아이디(영문,숫자4글자이상)" name="memberId" id="memberId" required>
			            <span class="guide ok">이 아이디는 사용가능합니다.</span>
			            <span class="guide error">이 아이디는 사용할 수 없습니다.</span>
			            <input type="hidden" id="idValid" value="0"/><!-- 사용불가한 아이디 0, 사용가능한 아이디 1 -->
			        </div>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" class="form-control" name="memberPassword" id="password" value="1234" required>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" class="form-control" id="passwordCheck" value="1234" required>
				</td>
			</tr>  
			<tr>
				<th>업체명</th>
				<td>	
					<input type="text" class="form-control" name="memberName" id="name" value="홍길동" required>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>	
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="memberPhone" id="memberPhone" maxlength="11" value="01098989898" required>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div id="memberEmail-container">
			            <input type="email" class="form-control" placeholder="abc@xyz.com" name="memberEmail" id="memberEmail" value="" required>
			            <span class="invalid-feedback">이미 가입된 이메일입니다.</span>
			            <input type="hidden" id="emailValid" value="0"/><!-- 사용불가 0, 사용가능 1 -->
			        </div>
				</td>
				<td>
			        <input type="button" id="btn-email-sendKey" value="이메일 인증"
			        		disabled/><!-- 완성후 기능 살려놓기 -->
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="emailKey" placeholder="인증코드를 입력하세요." required 
							readonly/>
					<input type="hidden" id="emailKeyValid" value="1"/><!-- 불일치 0, 일치 1 -->
				</td>
				<td><input type="button" id="btn-email-enterKey" value="확인"
						disabled/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text" class="form-control" placeholder="" name="memberAddress" id="address" value="서울시 강남구 역삼동 123" readonly required>
				</td>
			</tr>
			<tr>
				<th>상세주소</th>
				<td>	
					<input type="text" class="form-control" placeholder="" name="memberAddressEx" id="address-ex" value="">
				</td>
			</tr>
			<tr>
				<th>개업일</th>
				<td>	
					<input type="date" class="form-control" name="memberBirthday" id="birthday" value="1999-09-09" required/>
				</td>
			</tr> 
			<tr>
				<th>사업자등록번호</th>
				<td>
					<input type="text" name="sellerRegNo" placeholder="000-00-00000"/>
				</td>
			</tr>
			<tr>
				<th>사업자등록증</th>
				<td><input type="file" name="sellerRegFile" id="" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea class="enroll-agreement-content" cols="73" rows="5">서비스 이용 표준약관
[시행 2008. 7. 30.] [문화체육관광부훈령 제2008-0호, 2008. 7. 30., 제정]
과학기술정보통신부(디지털콘텐츠과), 044-202-6352

제1장 총칙
      
제1조(목적) 
이 약관은 회사가 온라인으로 제공하는 디지털콘텐츠(이하 "콘텐츠"라고 한다) 및 제반서비스의 이용과 관련하여 회사와 이용자와의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다.

제2조(정의) 
이 약관에서 사용하는 용어의 정의는 다음과 같습니다.

	1. "회사"라 함은 "콘텐츠" 산업과 관련된 경제활동을 영위하는 자로서 콘텐츠 및 제반서비스를 제공하는 자를 말합니다. 
	
	2. "이용자"라 함은 "회사"의 사이트에 접속하여 이 약관에 따라 "회사"가 제공하는 "콘텐츠" 및 제반서비스를 이용하는 회원 및 비회원을 말합니다. 
	
	3. "회원"이라 함은 "회사"와 이용계약을 체결하고 "이용자" 아이디(ID)를 부여받은 "이용자"로서 "회사"의 정보를 지속적으로 제공받으며 "회사"가 제공하는 서비스를 지속적으로 이용할 수 있는 자를 말합니다. 
	
	4. "비회원"이라 함은 "회원"이 아니면서 "회사"가 제공하는 서비스를 이용하는 자를 말합니다. 
	
	5. "콘텐츠"라 함은 정보통신망이용촉진 및 정보보호 등에 관한 법률 제2조 제1항 제1호의 규정에 의한 정보통신망에서 사용되는 부호·문자·음성·음향·이미지 또는 영상 등으로 표현된 자료 또는 정보로서, 그 보존 및 이용에 있어서 효용을 높일 수 있도록 전자적 형태로 제작 또는 처리된 것을 말합니다. 
	
	6. "아이디(ID)"라 함은 "회원"의 식별과 서비스이용을 위하여 "회원"이 정하고 "회사"가 승인하는 문자 또는 숫자의 조합을 말합니다. 
	
	7. "비밀번호(PASSWORD)"라 함은 "회원"이 부여받은 "아이디"와 일치되는 "회원"임을 확인하고 비밀보호를 위해 "회원" 자신이 정한 문자 또는 숫자의 조합을 말합니다. 

제3조(신원정보 등의 제공) "회사"는 이 약관의 내용, 상호, 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호, 모사전송번호, 전자우편주소, 사업자등록번호, 통신판매업 신고번호 및 개인정보관리책임자 등을 이용자가 쉽게 알 수 있도록 온라인 서비스초기화면에 게시합니다. 다만, 약관은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다. 

제4조(약관의 게시 등)   
① "회사"는 이 약관을 "회원"이 그 전부를 인쇄할 수 있고 거래과정에서 해당 약관의 내용을 확인할 수 있도록 기술적 조치를 취합니다. 

② "회사"는 "이용자"가 "회사"와 이 약관의 내용에 관하여 질의 및 응답할 수 있도록 기술적 장치를 설치합니다. 

③ "회사"는 "이용자"가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회, 환불조건 등과 같은 중요한 내용을 이용자가 쉽게 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 "이용자"의 확인을 구합니다. 

제5조(약관의 개정 등)
① "회사"는 온라인 디지털콘텐츠산업 발전법, 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제에 관한 법률 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다. 

② "회사"가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 서비스초기화면에 그 적용일자 7일 이전부터 적용일 후 상당한 기간동안 공지하고, 기존회원에게는 개정약관을 전자우편주소로 발송합니다. 

③ "회사"가 약관을 개정할 경우에는 개정약관 공지 후 개정약관의 적용에 대한 "이용자"의 동의 여부를 확인합니다. "이용자"가 개정약관의 적용에 동의하지 않는 경우 "회사" 또는 "이용자"는 콘텐츠 이용계약을 해지할 수 있습니다. 이때, "회사"는 계약해지로 인하여 "이용자"가 입은 손해를 배상합니다. 

제6조(약관의 해석) 
이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 온라인 디지털콘텐츠산업 발전법, 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제에 관한 법률, 문화체육관광부장관이 정하는 디지털콘텐츠이용자보호지침, 기타 관계법령 또는 상관례에 따릅니다. 
      </textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
			        <input type="checkbox" id="agree-terms" name="agreement-required" class="agree-check-box"/>
				    <label for="agree-terms">(필수) 서비스 이용약관에 동의합니다.</label>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea class="enroll-agreement-content" cols="73" rows="5">monong-monong 개인정보처리방침

[monong-monong]('monong.com', 이하 모농모농)이(가) 취급하는 모든 개인정보는 개인정보보호법 등 관련 법령상의 개인정보보호 규정을 준수하여 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.

1 개인정보의 처리 목적
  
① [monong-monong]은(는) 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.

고객 가입의사 확인, 고객에 대한 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 물품 또는 서비스 공급에 따른 금액 결제, 물품 또는 서비스의 공급·배송, 마케팅 및 광고에의 활용

2 개인정보의 처리 및 보유 기간 작성

① [monong-monong]은(는) 정보주체로부터 개인정보를 수집할 때 동의 받은 개인정보 보유·이용기간 또는 법령에 따른 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.

② 구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다.

고객 가입 및 관리 : 서비스 이용계약 또는 회원가입 해지시까지, 다만 채권·채무관계 잔존시에는 해당 채권·채무관계 정산시까지

전자상거래에서의 계약·청약철회, 대금결제, 재화 등 공급기록 : 5년

3 정보주체와 법정대리인의 권리·의무 및 그 행사방법

정보주체는 [monong-monong]에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.

	1. 개인정보 열람요구
	
	2. 오류 등이 있을 경우 정정 요구
	
	3. 삭제요구
	
	4. 처리정지 요구

4 처리하는 개인정보 항목

개인정보 처리업무: 홈페이지 회원가입 및 관리, 민원사무 처리, 재화 또는 서비스 제공, 마케팅 및 광고에의 활용

필수항목: 로그인ID, 비밀번호, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록

선택항목: 이메일, 성별, 이름

5 개인정보의 파기

파기절차

이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.

파기기한

이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.

6 개인정보 자동 수집 장치의 설치·운영 및 그 거부에 관한 사항

① [monong-monong]은 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.

② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 컴퓨터 내의 하드디스크에 저장되기도 합니다.

가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.

나. 쿠키의 설치·운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.

다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.

7 개인정보 보호책임자

이름: 000

소속: 운영팀

전화: 02-1234-5678

이메일: john.smith@example.com

8 개인정보의 안전성 확보 조치

개인정보의 암호화

이용자의 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.

9 개인정보처리방침의 변경

이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.

공고일자 : 2022년 07월 13일

시행일자 : 2022년 07월 13일
     				 </textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="checkbox" id="agree-privacy" name="agreement-required" class="agree-check-box"/>
       				<label for="agree-privacy">(필수) 개인정보 수집 및 이용약관에 동의합니다.</label>
				</td>
			</tr>
		</table>
		<sec:csrfInput />
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
	</form>
</div>
<script>
const ok = document.querySelector(".guide.ok");
const error = document.querySelector(".guide.error");
const invalidFeedBack = document.querySelector(".invalid-feedback");
const idValid = document.querySelector("#idValid");
const emailValid = document.querySelector("#emailValid");
const emailKeyValid = document.querySelector("#emailKeyValid");

document.memberEnrollFrm.addEventListener('submit', (e) => {
	//아이디 체크
	if(idValid.value == "0"){
		e.preventDefault();
		alert("유효한 아이디를 입력해주세요.");
		return;
	}
	//동의여부 체크
	const agreeRequired = document.querySelectorAll('input[name="agreement-required"]');
	let cntChkd = 0;
	agreeRequired.forEach((checkbox)=>{
		if(!checkbox.checked){
			e.preventDefault();
			cntChkd++;
		}		
	});
	if(cntChkd > 0){
		e.preventDefault();
		alert("필수항목에 동의하지 않으면 회원가입이 불가능해요.");
		return;
	}
	//이메일 인증 체크
	/*테스트용 가입처리시 인증 불가능. 전체 사이트 완성 후 주석풀기
	if(emailKeyValid === "0"){
		e.preventDefault();
		alert("이메일 인증코드를 확인해주세요.");
		return;
	}
	*/
});

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
	console.log(headers);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
		method : "POST",
		headers,
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

	if(email.length < 7){
		idValid.value = "0";
		invalidFeedBack.style.display = "none";
		return;
	}
	
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
			
			if(available){
				invalidFeedBack.style.display = "none";
				emailValid.value = "1";
			}
			else {
				invalidFeedBack.style.display = "inline";
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


//이메일 인증코드 전송
document.querySelector("#btn-email-sendKey").addEventListener('click', (e)=>{
	if(emailValid.value == "0"){
		alert("유효한 이메일을 입력해주세요.");
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
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>