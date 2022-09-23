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
    <div class="carousel-item active banner1">
      <img src="${pageContext.request.contextPath}/resources/images/banner_1.jpg" class="d-block w-100" alt="주간채소공지">
    </div>
    <div class="carousel-item banner2" id="showkModal" data-toggle="modal" data-target="#checkModal" data-backdrop="static" data-keyboard="false">
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

<!-- Modal -->
<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="checkModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="checkModalCenterTitle"><span class="onceTitle"></span></h5>
				<button type="button" class="close closeModalBtn" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"><span class="onceContent"></span></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeModalBtn" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
<script>
window.onload = function(){
	const weekCriterion = findMon();
	let url = `${pageContext.request.contextPath}/notification/popup/\${weekCriterion}.do`;
	window.open(url, '채소공지팝업', 'top=0, width=550, height=550, resizable=no, location=no');
}
// 배너 클릭 시 주간채소 모달창으로 공지
document.querySelector("#showkModal").addEventListener('click', () => {
	$.ajax({
		url: `${pageContext.request.contextPath}/notification/popup/recent.do`
	})
	.done(function(data, textStatus, xhr) {
		const {weekCriterion, vegComposition} = data;
		
		$('#checkModal').modal('show');
		const onceTitle = document.querySelector(".onceTitle");
		const onceContent = document.querySelector(".onceContent");
		onceTitle.innerText = '';
		onceTitle.innerText = weekCriterion + ' 주간채소공지';
		onceContent.innerText = '';
		onceContent.innerText = "  이번주에는 '" + vegComposition  + "' 제품들이 발송됩니다.";
		
		// 모달창 닫기
		$('.closeModalBtn').on('click', () => {
			$('#checkModal').modal('hide');
		});
	})
	.fail(function(xhr, textStatus, errorThrown) {
		console.log(textStatus, errorThrown);
	});
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