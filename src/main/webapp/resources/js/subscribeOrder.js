//주소 유효성 검사
document.querySelector("#sAddress").addEventListener('input', (e) => {
	const sAddress = e.target;
	const error = document.querySelector(".sAddressCheck.error");
	if(!/^[\S].+$/.test(sAddress.value)){
		error.style.display = "block";
		sAddress.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		sAddress.style.borderBottom = "1px solid #116530";
	}
});
// 핸드폰번호 유효성 검사
document.querySelector("#sPhone").addEventListener('input', (e) => {
	const sPhone = e.target;
	const error = document.querySelector(".sPhoneCheck.error");
	if(!/^[0-9]{11}$/.test(sPhone.value)){
		error.style.display = "block";
		sPhone.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		sPhone.style.borderBottom = "1px solid #116530";
	}
});
// 수령인 유효성 검사
document.querySelector("#sRecipient").addEventListener('input', (e) => {
	const sRecipient = e.target;
	const error = document.querySelector(".sRecipientCheck.error");
	if(!/^[a-zA-z가-힣]+$/.test(sRecipient.value)){
		error.style.display = "block";
		sRecipient.style.borderBottom = "1px solid red";
		return;
	}
	else {
		error.style.display = "none";
		sRecipient.style.borderBottom = "1px solid #116530";
	}
});
// 주소 API
document.querySelector("#researchButton").addEventListener('click', function(){
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			// 주소 정보를 해당 필드에 넣는다.
			document.getElementById("sAddress").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("sAddressEx").focus();
		}
	}).open();
});