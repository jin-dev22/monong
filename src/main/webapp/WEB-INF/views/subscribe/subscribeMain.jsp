<%@page import="com.kh.monong.member.model.dto.MemberEntity"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.kh.monong.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/subscribe/sMain.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/subscribe/sReview.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<div class="container subMain-container">
	<div class="row row1">
		<div class="col"><a href="#sub-info">이용 안내</a></div>
	</div>
	<div class="row">
		<div class="col"><a href="#sub-review">이용 후기</a></div>
	</div>
</div>
<div id="sub-info"></div>
<h1 id="sub-info">모농모농 정기구독 이용안내</h1>
	<div class="s-info-step step1">
		<div class="s-info-step-title">
			<span class="badge rounded-pill text-dark">Step 1</span> <span>구독신청</span>
			<p>나에게 딱 맞는 플랜으로 신청하세요!</p>
		</div>
		<div class="s-info-step1">
			<div class="s-info-step1-product">
				<p>상품</p>
				<c:forEach items="${subscriptionProduct}" var="product" varStatus="vs">
					<div class="" data-sproduct="${product.SProductCode}" data-index="${vs.index}">
						<div class="s-info-step1-img">
							<img src="${pageContext.request.contextPath}/resources/images/subscribe/${product.SProductName}.jpg" alt="${product.SProductName}" >
						</div>
						<span class="s-product-name">${product.SProductName}</span>
		                <span class="s-product-price">
		                	<fmt:formatNumber value="${product.SProductPrice}" pattern="#,###원" />
		                </span>
		                <span class="s-product-info">${product.SProductInfo}용</span>
					</div>
				</c:forEach>
			</div>
			<div class="mean-nothing-div"></div>
			<div class="s-info-step1-cycle">
				<p>배송주기</p>
				<div class="mean-nothing-box">
					<span>1주</span> <span>#프로요리사</span>
				</div>
				<div class="mean-nothing-box">
					<span>2주</span> <span>#해먹는 재미</span>
				</div>
				<div class="mean-nothing-box">
					<span>3주</span> <span>#요리초보</span>
				</div>
			</div>
			<div class="s-info-step1-exclude">
				<p>제외 채소 선택</p>
				<span>제외하고 싶은 채소를 최대 5개까지 선택하실 수 있습니다.</span><br /> <span>배송되는
					주간의 다른 채소로 대채해 보내드립니다.</span>
			</div>
	
		</div>
	</div>
	<div class="s-info-step step2">
		<div class="s-info-step-title">
			<span class="badge rounded-pill text-dark">Step 2</span> <span>배송</span>
			<p>설레는 금요일~ 신선한 채소를 배송받아요!</p>
		</div>
		<div class="step2-wrapper">
			<div class="s-info-step2-box">
				<p>월</p>
				<i class="bi bi-megaphone-fill"></i>
				<p>주간 채소 공지</p>
			</div>
			<div class="step2-arrow">
				<i class="bi bi-arrow-right-short"></i>
			</div>
			<div class="s-info-step2-box">
				<p>수</p>
				<i class="bi bi-credit-card-fill"></i>
				<p>결제</p>
			</div>
			<div class="step2-arrow">
				<i class="bi bi-arrow-right-short"></i>
			</div>
			<div class="s-info-step2-box">
				<p>금</p>
				<i class="bi bi-box2-fill"></i>
				<p>배송 완료</p>
			</div>
		</div>
		<div class="step2-footer">
			<span>&#128504; 배송 미루기</span> <span>&#128504; 구독 플랜 수정하기</span><br />
			<span>※ 매주 화요일까지 변경 가능</span><br />
			<sec:authorize access="isAnonymous()">
				<button type="button" id="gotoLogin" class="btn btn-EA5C2B">구독하기</button>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_SELLER')">
					<button type="button" id="onlyMemberUse" class="btn btn-EA5C2B" disabled>구독하기</button></br>
					<span>판매자는 이용하실 수 없습니다. 일반회원으로 회원가입 후 이용해주세요!</span>
				</sec:authorize>
			<sec:authorize access="hasRole('ROLE_MEMBER')">
		    	<c:if test="${isSubscribe eq 'Y'}">
					<button type="button" id="gotoPlan" class="btn btn-EA5C2B" disabled>구독하기</button>
				</c:if>
				<c:if test="${isSubscribe ne 'Y'}">
					<button type="button" id="gotoPlan" class="btn btn-EA5C2B">구독하기</button>
				</c:if>
			</sec:authorize>
		</div>
	</div>

<div id="sub-review"></div>
<h1>이용후기</h1>
<sec:authentication property="principal" var="loginMember" scope="page"/>

<sec:authorize access="isAuthenticated()">
	<input type="hidden" class="s-review-login-member" data-member-id="${loginMember.memberId}"/>
</sec:authorize>

<p>모농모농의 정기구독을 이용하신 회원님들의 후기입니다.</p>
<div class="s-review-statistics">
    <div class="s-review-stat-star">전체 만족도<span class="s-review-statistics-data">${sReviewStarAvg}</span></div>
    <div class="s-review-stat-num">전체 후기 수<span class="s-review-statistics-data">${totalContent}</span></div>
</div>

<div class="s-reviews-wrapper"></div>

<nav id="pagebar">

</nav>

<!-- Modal -->
<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="modal-img"></div>
      	<div class="modal-s-review-container">
      		<div class="modal-s-review-member-date">
			    <div class="modal-s-review-member-id"></div>
			    <div class="modal-s-review-written-date"></div>
			</div>
			<div class="modal-s-times"></div>
			<div class="modal-s-review-star">
			    <span class="modal-s-review-star-filled">★★★★★</span>
			    <span class="modal-s-review-unfilled">★★★★★</span>
		    </div>
		    <div class="modal-s-review-content"></div>
			<div class="modal-s-review-recommend" onclick="sReviewRecommend();">
				<button type="button" class="btn-s-review-recommend" data-recommended="false">👍&nbsp도움돼요<span class="modal-s-review-recommend-num"></span></button>
	    	</div>
	    </div>
      </div>
    </div>
  </div>
</div>

<script>
//비로그인 - 구독하기 버튼 클릭 시 로그인페이지로 이동
const gotoLogin = document.querySelector("#gotoLogin");
if(gotoLogin != null){
	gotoLogin.addEventListener('click', () => {
		alert("로그인 후 이용해주세요!");
		location.href = `${pageContext.request.contextPath}/member/memberLogin.do`;
	});
}
const gotoPlan = document.querySelector("#gotoPlan");
if(gotoPlan != null){
	gotoPlan.addEventListener('click', () => {
		location.href = `${pageContext.request.contextPath}/subscribe/subscribePlan.do`;
	});
}

window.onload = () => {
	sReviewList();
}

const sReviewList = (num) => {
	
	// 페이징용
	let cPage = num;
	const limit = 8;
	let totalPages = 0;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/subscribe/subscribeReviewList.do",
		data: {cPage},
		method : "GET",
		success(result){
			// console.log('result', result);
			console.log('sReviewList', result['sReviewList']);
			const reviews = result['sReviewList'];
			const cPage = result['cPage'];
			console.log('cPage', cPage);
			const totalContent = result['totalContent'];
			console.log('totalContent', totalContent);

			// 페이징
			if(totalContent == 0){
				document.querySelector("#pagebar").innerHTML = "";
				return;
			}
			else {
				totalPages = Math.ceil(totalContent / limit);
				// pageLink(현재페이지, 전체페이지, 호출할 함수 이름)
				let htmlStr = pageLink(cPage, totalPages, "sReviewList");
				document.querySelector("#pagebar").innerHTML = "";
				document.querySelector("#pagebar").innerHTML = htmlStr;
			};			
			
			let html = '';
	
			reviews.forEach((review, index) => {
				const sAttach = review.sattachments;
				console.log('sAttach', sAttach);
				
				const {memberId, sreviewContent, sreviewCreatedAt, sreviewStar, stimes} = review;
				
				html += `
				<div class="s-review-wrapper" onclick="reviewDetail(this,'\${review.sreviewNo}');" data-toggle="modal" data-target="#myModal">`;
				if(!sAttach[0]){
					console.log('이미지 없음');
					html += `
						<div class="s-review-container no-img">`;
				}
				else{
					console.log('이미지 있음');
					html += `
						<div>
							<img src="${pageContext.request.contextPath}/resources/upload/subscribe/review/\${sAttach[0].sreviewRenamedFilename}">
						</div>
						<div class="s-review-container with-img">`;
				}
				
				html += `
					<div class="s-review-star-times">
						<span class="s-review-star">
						    <span class="s-review-star-filled" style="width:\${sreviewStar*20}%">★★★★★</span>
						    <span class="s-review-unfilled">★★★★★</span>
					    </span>
					    <span class="s-times">\${stimes}회차 구독</span>
					</div>`;
					
			    if(!sAttach[0]){
			    	html += `
			    		<p class="s-review-content">\${sreviewContent.length > 187? sreviewContent.substr(0, 187) + '...': sreviewContent}</p>`;
			    }
				else{
					html += `
						<p class="s-review-content">\${sreviewContent.length > 41 ? sreviewContent.substr(0, 41) + '...': sreviewContent}</p>`;
			    }
			    
			    const year = sreviewCreatedAt[0];
			    const month = sreviewCreatedAt[1];
			    const day = sreviewCreatedAt[2];
			    const writtenDate = `\${year}-\${month >= 10 ? month : '0' + month}-\${day >= 10 ? day : '0' + day}`;
		        console.log('writtenDate', writtenDate);
		        
			    html += `
			   		</div>
			    	<div class="s-review-member-date">
						<div class="s-review-member-id">\${memberId.substring(0, memberId.length-3) + '***'}</div>
						<div class="s-review-written-date">\${writtenDate}</div>
					</div>
				</div>`;
			
			});
			document.querySelector(".s-reviews-wrapper").innerHTML = html;
			/* document.querySelector(".s-review-page-bar").innerHTML = pagebar; */
				
		},
		error : console.log
	});

};

function pageLink(cPage, totalPages, funName){
	cPage = Number(cPage);
	totalPages = Number(totalPages);
	let pagebarTag = "";
	const pagebarSize = 5;
	let pagebarStart = (Math.floor((cPage - 1) / pagebarSize) * pagebarSize) + 1;
	let pagebarEnd = pagebarStart + pagebarSize - 1;
	let pageNo = pagebarStart;
	
	pagebarTag += "<ul class=\"pagination justify-content-center\">\r\n";
	
	// 1. previous 
	if(pageNo == 1) {
		pagebarTag += "<li class=\"page-item disabled\">\r\n"
				+ "	      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\">\r\n"
				+ "	        <span aria-hidden=\"true\">&laquo;</span>\r\n"
				+ "	        <span class=\"sr-only\">Previous</span>\r\n"
				+ "	      </a>\r\n"
				+ "	    </li>\r\n";
	}
	else {
		pagebarTag += "<li class=\"page-item\">\r\n"
				+ "	      <a class=\"page-link\" href=\'javascript:" + funName + "(" + (pageNo - 1) + ");\' aria-label=\"Previous\">\r\n"
				+ "	        <span aria-hidden=\"true\">&laquo;</span>\r\n"
				+ "	        <span class=\"sr-only\">Previous</span>\r\n"
				+ "	      </a>\r\n"
				+ "	    </li>\r\n";
	}
	
	// 2. pageNo
	while(pageNo <= pagebarEnd && pageNo <= totalPages) {
		if(pageNo == cPage) {
			pagebarTag += "<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo + "</a></li>\r\n";
		}
		else {
			pagebarTag += "<li class=\"page-item\"><a class=\"page-link\" href=\'javascript:" + funName + "(" + pageNo + ");'>" + pageNo + "</a></li>\r\n";
		}
		pageNo++;
	}
	
	// 3. next
	if(pageNo > totalPages) {
		pagebarTag += "<li class=\"page-item disabled\">\r\n"
				+ "	      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
				+ "	        <span aria-hidden=\"true\">&raquo;</span>\r\n"
				+ "	        <span class=\"sr-only\">Next</span>\r\n"
				+ "	      </a>\r\n"
				+ "	    </li>\r\n";
	}
	else {
		pagebarTag += "<li class=\"page-item\">\r\n"
				+ "	      <a class=\"page-link\" href=\'javascript:" + funName + "(" + pageNo + ");\' aria-label=\"Next\">\r\n"
				+ "	        <span aria-hidden=\"true\">&raquo;</span>\r\n"
				+ "	        <span class=\"sr-only\">Next</span>\r\n"
				+ "	      </a>\r\n"
				+ "	    </li>\r\n";
	}
	
	pagebarTag += "</ul>";
	return pagebarTag;
};


const reviewDetail = (obj, sReviewNo) => {
	console.log('obj: ', obj, 'sReviewNo: ', sReviewNo);

	const loginMember = document.querySelector(".s-review-login-member");
	console.log('loginMember', loginMember);
	
	// 로그인된 상태인 경우 -> 후기 게시글 추천여부 확인
	if(loginMember != null){
		const memberId = loginMember.dataset.memberId;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/subscribe/subscribeReviewRecommended.do",
			data: {sReviewNo, memberId},
			method : "GET",
			success(recommended){
				const btnRecommend = document.querySelector(".btn-s-review-recommend");
				
				if(recommended){
					btnRecommend.dataset.recommended = "true";
				}
				else{
					btnRecommend.dataset.recommended = "false";
				}
				
			},
			error : console.log
		});
	}
	
	$.ajax({
		url : "${pageContext.request.contextPath}/subscribe/subscribeReviewDetail.do",
		data: {sReviewNo},
		method : "GET",
		success(review){
			const {memberId, sreviewContent, sreviewCreatedAt, sreviewRecommendNum, sreviewStar, stimes} = review;
			const sAttach = review.sattachments;
			console.log('sAttach', sAttach);
			
		 	const modalImg = document.querySelector(".modal-img");
			if(sAttach.length >= 1){
				document.querySelector(".modal-dialog").classList.remove("no-img");
				document.querySelector(".modal-dialog").classList.add("with-img");
				
				let html;
				html = `<img src="${pageContext.request.contextPath}/resources/upload/subscribe/review/\${sAttach[0].sreviewRenamedFilename}" class="main-img" alt="대표첨부사진" width="300px"/>`;
				
				if(sAttach.length >= 2){
					html += `
			            <div class="sub-imgs">
				            <img src="${pageContext.request.contextPath}/resources/upload/subscribe/review/\${sAttach[0].sreviewRenamedFilename}" class="sub-img" alt="첨부사진1" onclick="viewImg(this)">
				            <img src="${pageContext.request.contextPath}/resources/upload/subscribe/review/\${sAttach[1].sreviewRenamedFilename}" class="sub-img" alt="첨부사진2" onclick="viewImg(this)">`;
					if(sAttach.length === 3){
						html += `
			            		<img src="${pageContext.request.contextPath}/resources/upload/subscribe/review/\${sAttach[2].sreviewRenamedFilename}" class="sub-img" alt="첨부사진3" onclick="viewImg(this)">`;
					}
				}
				
				html += `</div>`;
				
		     	modalImg.innerHTML = html;
			}
			else{
				document.querySelector(".modal-dialog").classList.remove("with-img");
				document.querySelector(".modal-dialog").classList.add("no-img");
				
				// 다른 게시물 클릭 시 모달창에 넣어놓았던 이미지 html 제거
				modalImg.innerHTML = '';
			}
			
			const moTimes = document.querySelector(".modal-s-times");
			moTimes.innerHTML = `\${stimes}회차 구독`;
			
			const moStar = document.querySelector(".modal-s-review-star-filled");
			moStar.style.width=`\${sreviewStar*20}%`;
			
			const moContent = document.querySelector(".modal-s-review-content");
			moContent.innerHTML = `\${sreviewContent}`;
			
			const moMemberId = document.querySelector(".modal-s-review-member-id");
			moMemberId.innerHTML = `\${memberId.substring(0, memberId.length-3) + '***'}`;
						
			const year = sreviewCreatedAt[0];
			const month = sreviewCreatedAt[1];
			const day = sreviewCreatedAt[2];
			const writtenDate = `\${year}-\${month >= 10 ? month : '0' + month}-\${day >= 10 ? day : '0' + day}`;
			
			const moWrittenDate = document.querySelector(".modal-s-review-written-date");
			moWrittenDate.innerHTML = `\${writtenDate}`;
			
			const moRecommendNum = document.querySelector(".modal-s-review-recommend-num");
			moRecommendNum.innerHTML = `\${sreviewRecommendNum}`;
			moRecommendNum.setAttribute('data-s-review-no', sReviewNo); // 후기추천 기능 사용 시 참조할 게시글번호 저장
			
		},
		error : console.log
	});
	
	setTimeout(showModal, 100);

}

const showModal = () => {
	var myModal = new bootstrap.Modal(document.getElementById('myModal'), 'show');
	myModal.show();
};

const viewImg = (selectedImg) => {
	selectedImg.style.opacity= "1";
    document.querySelector(".main-img").src = selectedImg.src;
    
	document.querySelectorAll(".sub-img").forEach(function(subImg){
		if(subImg !== selectedImg){
			subImg.style.opacity= "0.5";
		}
	});

}

const sReviewRecommend = () => {	
	const loginMember = document.querySelector(".s-review-login-member");
	console.log('loginMember', loginMember);
	
	if(loginMember === null){
		alert('로그인 후 이용가능합니다.');
		location.href = `${pageContext.request.contextPath}/member/memberLogin.do`;
	}
	else{
		console.log('loginMember', loginMember.dataset.memberId);
		const memberId = loginMember.dataset.memberId;
	  
		const recommendNum = document.querySelector(".modal-s-review-recommend-num");		
		const sReviewNo = recommendNum.dataset.sReviewNo;
		
		const btnRecommend = document.querySelector(".btn-s-review-recommend");
		const recommended = btnRecommend.dataset.recommended;	
		
		// 추천이 되어있는 경우 -> 추천 취소하기
		if(recommended === "true"){
			$.ajax({
				url : "${pageContext.request.contextPath}/subscribe/subscribeReviewRecommendCancel.do",
				data: {memberId, sReviewNo},
				method : "POST",
				beforeSend : function(xhr){  
					            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				       		 },
				success(result){
					recommendNum.innerHTML = Number(recommendNum.innerHTML) - 1;
					btnRecommend.dataset.recommended = "false";
				},
				error : console.log
			});
		}
		
		// 추천이 안되어있는 경우 -> 추천하기
		else{
			$.ajax({
				url : "${pageContext.request.contextPath}/subscribe/subscribeReviewRecommendAdd.do",
				data: {memberId, sReviewNo},
				method : "POST",
				beforeSend : function(xhr){  
					            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				       		 },
				success(result){
					recommendNum.innerHTML = Number(recommendNum.innerHTML) + 1;
					btnRecommend.dataset.recommended = "true";
				},
				error : console.log
			});
		}
	
	}
};

</script>
<style>

</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>