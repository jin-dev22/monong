<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
</section>
<footer>
	<nav class="footer1">
		<div class="service-center">
			<span>모농모농 고객센터</span>
			<span style="color: #EA5C2B">&#128222;02-5959-8282</span><br />
			<span>월요일 ~ 금요일</span>
			<span>10:00 ~ 18:00 (점심시간 12:00 ~ 13:00)</span><br />
			<span>토 · 일 · 공휴일</span>
			<span>휴무</span>
		</div>
		<div>
			<input type="button" class="btn btn-EA5C2B" onclick="location.href='${pageContext.request.contextPath}/inquire/inquireAdmin.do';" value="문의하기">
			<input type="button" class="btn btn-EA5C2B-reverse" onclick="faq()" value="자주 묻는 질문">
		</div>
	</nav>
	<nav class="footer2">
		<img src="${pageContext.request.contextPath}/resources/images/logo.PNG" class="logo" alt="모농모농 로고">
		<div>
			<span>상호명: 모농모농</span>
			<span>대표: 이파리들</span>
			<span>사업자등록번호: 123-45-67890</span>
			<span>소재지: 서울특별시 강남구 테헤란로14길 6 남도빌딩</span>
		</div>
		<div>
			<span>통신판매업 신고번호: 2022-서울강남-0101</span>
			<span class="pointer">제휴 및 입점 문의: monong@monong.co.kr</span>
			<span class="pointer">농산물 납품 및 긴급구출 제보: help@monong.co.kr</span>
		</div>
		<div>
			<span>서비스 이용약관</span>
			<span>개인정보 처리방침</span>
			<span>Copyrithgⓒ 2022 주식회사 모농모농 All rights reserved.</span>
		</div>
	</nav>
</footer>
<script>
const faq = () => {
	location.href = `${pageContext.request.contextPath}/common/faqList.do`;
};
</script>
<!-- footer 끝 -->
</body>
</html>