<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<section id="faq">
	<h2>자주 묻는 질문&#128269;</h2>
	<nav class="navbar">
		<div class="searchFaqFrm">
			<input class="searchLikeKeyword" name="searchLikeKeyword" type="search" placeholder="&#128269; 검색" aria-label="Search">
			<button type="button" id="btn-searchFaq" class="btn btn-EA5C2B">검색</button>
		</div>
	</nav>
	<div class="faq-menu">
		<ul class="faq-menu-gruop">
			<li class="faq-menu-list" data-type="total">전체보기</li>
			<li class="faq-menu-list" data-type="m">회원정보</li>
			<li class="faq-menu-list" data-type="s">구독</li>
			<li class="faq-menu-list" data-type="d">직거래</li>
			<li class="faq-menu-list" data-type="o">결제</li>
		</ul>
		<div class="faq-wrapper">
			<c:forEach items="${faqList}" var="faqList" varStatus="vs">
				<div class="faq-menu-title">${vs.count} ${faqList.faqTitle}
					<p class="faq-menu-content">${faqList.faqContent}</p>
				</div>
			</c:forEach>
		</div>
	</div>
	<div id="faq-pagebar">${pagebar}</div>
</section>
<script>
$(document).on('click', '.faq-menu-title', function(e){
	$(e.target).children().slideToggle();
	$('.faq-menu-content').not($(e.target).children()).slideUp();
	
});

const faqType = document.querySelectorAll(".faq-menu-list").forEach((type) => {
	type.addEventListener('click', (e) => {
		const cPage = 1;
		const type = e.target.dataset.type;
		const wrapper = document.querySelector(".faq-wrapper");
		
		$.ajax({
			url: `${pageContext.request.contextPath}/common/searchType.do`,
			method: 'GET',
			data: {type, cPage},
			success(response){
				if(type == 'total'){
					const {searchFaqList, pagebar} = response;
					renderFaq(searchFaqList, ".faq-wrapper");
					document.querySelector("#faq-pagebar").innerHTML = '';
					document.querySelector("#faq-pagebar").innerHTML = `${pagebar}`;
				}
				else {
					renderFaq(response, ".faq-wrapper");
					document.querySelector("#faq-pagebar").innerHTML = '';
				}
			},
			error: console.log
		});
	});
});

document.querySelector("#btn-searchFaq").addEventListener('click', (e) => {
	const keyword = document.querySelector("[name=searchLikeKeyword]").value;
	const wrapper = document.querySelector(".faq-wrapper");
	const regExp = /^\S/;
	if(!regExp.test(keyword)){
		alert("정확한 검색어를 입력해주세요.");
		return;
	}
	
	$.ajax({
		url: `${pageContext.request.contextPath}/common/searchLikeKeyword.do`,
		method: 'GET',
		data: {keyword},
		success(response){
			renderFaq(response, ".faq-wrapper");
			document.querySelector("#faq-pagebar").innerHTML = '';
			document.querySelector(".searchLikeKeyword").value = '';
		},
		error: console.log
	});
	
});

const renderFaq = (response, id) => {
	const wrapper = document.querySelector(id);
	let html = ``;
	if(response.length){
		let i = 1;
		response.forEach((faq) => {
			const {faqTitle, faqContent} = faq;
			html += `
				<div class="faq-menu-title">\${i} \${faqTitle}
					<p class="faq-menu-content">\${faqContent}</p>
				</div>
			`;
			i++;
		});
	}
	else {
		html += `
			<div class="text-center" style="margin-top: 100px;">조회결과가 없습니다.</div>
		`;
	}
	wrapper.innerHTML = html;
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>