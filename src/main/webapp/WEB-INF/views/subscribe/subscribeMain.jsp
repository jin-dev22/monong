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
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="모농모농"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/subscribe/sReview.css">

<h1>정기구독</h1>


<h1>후기</h1>

<sec:authentication property="principal" var="loginMember" scope="page"/>

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
	     	<div class="modal-s-review-star-times">
				<span class="modal-s-review-star">
				    <span class="modal-s-review-star-filled">★★★★★</span>
				    <span class="modal-s-review-unfilled">★★★★★</span>
			    </span>
			    <span class="modal-s-times"></span>
		    </div>
		    <div class="modal-s-review-content"></div>
		    <div class="modal-s-review-member-id"></div>
		    <div class="modal-s-review-recommend-wrapper">
	    	<div class="modal-s-review-recommend-info">
	    		<span class="modal-s-review-recommend-num"></span>
	    		<span class="modal-s-review-recommend-content">명의 회원이 추천한 리뷰입니다.</span>
	    	</div>
	    	<c:if test="${loginMember.memberId ne null}">
				<div class="modal-s-review-recommend" onclick="sReviewRecommend();">
		    		<input type="button" class="btn-s-review-recommend" value="👍추천하기" />
		    	</div>
		    </c:if>
		    </div>
	    </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<script>
const sReviewRecommend = () => {
	const recommendNum = document.querySelector(".modal-s-review-recommend-num");	
	console.log(recommendNum.dataset.sReviewNo);
	
	const sReviewNo = recommendNum.dataset.sReviewNo;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/subscribe/subscribeReviewRecommend.do",
		data: {sReviewNo},
		method : "POST",
		beforeSend : function(xhr){  
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		       		 },
		success(result){
    		const recommendNum = document.querySelector(".modal-s-review-recommend-num");
			recommendNum.innerHTML = Number(recommendNum.innerHTML) + 1;
		},
		error : console.log
	});
};

</script>
<p>모농모농의 정기구독을 이용하신 고객님들의 후기입니다.</p>

 <div class="s-review-statistics">
        <div class="s-review-star">전체 만족도: ${sReviewStarAvg}</div>
        <div class="s-review-num">전체 후기 수: ${totalContent}</div>
    </div>
<div class="s-reviews-wrapper"></div>

<nav class="s-review-page-bar">
	${pagebar}
</nav>

<script>
window.onload = () => {
	$.ajax({
		url : "${pageContext.request.contextPath}/subscribe/subscribeReviewList.do",
		method : "GET",
		success(result){
			console.log('result', result);
			console.log('result', result['sReviewList']);
			const reviews = result['sReviewList'];
			console.log('result', result['pagebar']);
			const pagebar = result['pagebar'];

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
					/* 구독 작성 기능 완료 후 이미지 경로 수정 진행 */
					html += `
						<div>
							<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg">
						</div>
						<div class="s-review-container with-img">`;
				}
				
				html += `
					<div class="s-review-star-times">
						<span class="s-review-star">
						    <span class="s-review-star-filled" style="width:\${sreviewStar*20}%">★★★★★</span>
						    <span class="s-review-unfilled">★★★★★</span>
					    </span>
					    <span class="s-times">\${stimes}회차 구독회원</span>
					</div>`;
					
			    if(!sAttach[0]){
			    	html += `
			    		<p class="s-review-content">\${sreviewContent}</p>`;
			    }
				else{
					html += `
						<p class="s-review-content">\${sreviewContent.length > 40 ? sreviewContent.substr(0, 40) + '...': sreviewContent}</p>`;
			    }
			    html += `
			   		</div>
					<div class="s-review-member-id">\${memberId}</div>
				</div>`;
			
			});
			document.querySelector(".s-reviews-wrapper").innerHTML = html;
			document.querySelector(".s-review-page-bar").innerHTML = pagebar;
				
		},
		error : console.log
	});
	
}; 

const reviewDetail = (obj, sReviewNo) =>{
	console.log('obj: ', obj, 'sReviewNo: ', sReviewNo);
	
	$.ajax({
		url : "${pageContext.request.contextPath}/subscribe/subscribeReviewDetail.do",
		data: {sReviewNo},
		method : "GET",
		success(review){
			console.log('review(modal)', review);
			const sAttach = review.sattachments;
			console.log('sAttach',sAttach);

			const {memberId, sreviewContent, sreviewCreatedAt, sreviewRecommendNum, sreviewStar, stimes} = review;
			
		 	const modalImg = document.querySelector(".modal-img");
			if(sAttach[0]){
				let html;
					/* 구독 작성 기능 완료 후 이미지 경로 수정 진행 */
					html = `
				      	<img src="${pageContext.request.contextPath}/resources/images/subscribe/싱글.jpg" width="300px" class="modal-s-review-img"/>
				      `;
			      modalImg.innerHTML = html;
			}
			else{
				// 다른 게시물 클릭 시 넣어놓았던 이미지 html 제거
				modalImg.innerHTML = '';
			}
			const moTimes = document.querySelector(".modal-s-times");
			moTimes.innerHTML = `\${stimes}회차 구독`;
			
			const moStar = document.querySelector(".modal-s-review-star-filled");
			moStar.style.width=`\${sreviewStar*20}%`;
			
			const moContent = document.querySelector(".modal-s-review-content");
			moContent.innerHTML = `\${sreviewContent}`;
			
			const moMemberId = document.querySelector(".modal-s-review-member-id");
			moMemberId.innerHTML = `\${memberId}`;
			
			const moRecommendNum = document.querySelector(".modal-s-review-recommend-num");
			moRecommendNum.innerHTML = `\${sreviewRecommendNum}`;
			moRecommendNum.setAttribute('data-s-review-no', sReviewNo);
	
		},
		error : console.log
	});
	
	setTimeout(showModal, 100);
}

const showModal = () => {
	var myModal = new bootstrap.Modal(document.getElementById('myModal'), 'show');
	myModal.show();
}
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>