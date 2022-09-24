<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농"></jsp:param>
</jsp:include>

<!-- 메인화면 슬라이드 -->
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
	<div class="carousel-indicators">
		<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
	</div>
	<div class="carousel-inner">
		<div class="carousel-item active banner1" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do'">
			<img src="${pageContext.request.contextPath}/resources/images/banner_1.jpg" class="d-block w-100" alt="주간채소공지">
		</div>
		<div class="carousel-item banner2" id="show_popup">
			<img src="${pageContext.request.contextPath}/resources/images/banner_2.jpg" class="d-block w-100" alt="채소구성">
		</div>
		<div class="carousel-item banner3">
			<img src="${pageContext.request.contextPath}/resources/images/banner_3.jpg" class="d-block w-100" alt="브랜드스토리">
		</div>
	</div>
	<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		<span class="visually-hidden">Previous</span>
	</button>
	<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span>
		<span class="visually-hidden">Next</span>
	</button>
</div>

<!-- 가격동향 -->
<table>
	<thead></thead>
	<tbody></tbody>
</table>

<script>
window.onload = function(){
	//쿠키 불러오기
	function getCookie(name){
		let obj = name + "=";
		let x = 0;
		while(x <= document.cookie.length){
			let y = (x + obj.length);
			if(document.cookie.substring(x, y) == obj ){
				if((endOfCookie = document.cookie.indexOf(";", y)) == -1)
					endOfCookie = document.cookie.length;
				value = document.cookie.substring(y, endOfCookie);
				return unescape(value);
			}
			x = document.cookie.indexOf(" ", x) + 1;
			if ( x == 0 ) break; 
		};
	    return "";
	};

	$(function(){    
		if(getCookie("popToday") != "close"){
			const weekCriterion = findMon();
			let url = `${pageContext.request.contextPath}/notification/popup/\${weekCriterion}.do`;
			window.open(url, '채소공지팝업', 'top=0, width=550, height=550, resizable=no, location=no');
		}
	});

}
// 배너 클릭 시 주간채소 팝업창으로 공지
document.querySelector("#show_popup").addEventListener('click', () => {
	let url = `${pageContext.request.contextPath}/notification/popup/recent.do`;
	window.open(url, '채소공지팝업2', 'top=0, width=550, height=550, resizable=no, location=no');
	
});

// 금주 월요일 날짜 계산
const findMon = () => {
	const today = new Date();
	const todayDay = today.getDay();
	const MONDAY_SUM = 1;
	
	// 일요일이라면 -6
	if(todayDay == 0){
		new Date(today.setDate(today.getDate() - 6));
	}
	// 월 ~ 토요일이라면
	if(todayDay != 0){
		new Date(today.setDate(today.getDate() - (todayDay - MONDAY_SUM)));
	}
	
	let yy = today.getFullYear().toString().substring(2);
	let month = today.getMonth() + 1;
	let date = today.getDate();
	month = month < 10 ? '0' + month : month;
	date = date < 10 ? '0' + date : date;
	
	return yy + month + date;
};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>