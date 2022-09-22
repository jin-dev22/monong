<%@page import="com.kh.monong.subscribe.model.dto.SubscriptionOrder"%>
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
<jsp:include page="/WEB-INF/views/member/memberMyPage.jsp">
	<jsp:param name="title" value="모농모농-마이페이지"></jsp:param>
</jsp:include>
<style>
/* ----- 미송 시작 ----- */
.s-review-content{
	width: 530px;
	/* padding: 0 230px; */
}

.table-s-review-star{
	width: 100px;
}

.s-review-star{
	color: #aaa9a9; 
	position: relative;
	width: max-content;
}

.s-review-star-filled{
    color: #F6D860;
    /* padding: 0; */
    position: absolute;
    /* z-index: 1; */
    /* display: flex; */
    overflow: hidden;
    width: 0;
}
/* ----- 미송 끝 ----- */
</style>

<div id="member-reviewList-container">
<!-- 미송 시작 -->
<c:if test="${not empty sReviewList}">
	<table id="member-subScription-tbl" class="table table-borderless table-striped">
		<thead>
			<tr>
				<th>구독회차</th>
				<th>후기내용</th>
				<th class="table-s-review-star">별점</th>			    
				<th>작성일</th>			    
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${sReviewList}" var="sReview">
			<tr>
				<td>${sReview.STimes}회차</td>
				<td class="s-review-content" data-s-review-no="${sReview.SReviewNo}">
					<c:choose>
					 	<c:when test="${fn:length(sReview.SReviewContent) gt 38}">
					 		${fn:substring(sReview.SReviewContent, 0, 38)}...
					 	</c:when>
					 	<c:otherwise>
					 		${sReview.SReviewContent}
					 	</c:otherwise>
					</c:choose>
				</td>
				<td class="table-s-review-star">
				<div class="s-review-star">
					<span class="s-review-star-filled" style="width:${sReview.SReviewStar*20}%">★★★★★</span>
					<span class="s-review-unfilled">★★★★★</span>
				</div>
				</td>
				<td>
					<fmt:parseDate value="${sReview.SReviewCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
					<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</c:if>
<nav class="s-review-page-bar">
	${pagebar}
</nav>
<!-- 미송 끝 -->
</div>
<script>
/* ----- 미송 시작 ----- */
document.querySelectorAll(".s-review-content").forEach(function(review){
	review.addEventListener('click', (e) => {
		console.log('review', review);
		const sReviewNo = review.dataset.sReviewNo;
		console.log('sReviewNo: ', sReviewNo);
	
		$.ajax({
			url : "${pageContext.request.contextPath}/member/memberSubscribeReviewDetail.do",
			data: {sReviewNo},
			method : "GET",
			success(result){
				console.log(result);
				const sAttach = result.sattachments;
				const {sreviewContent} = result;
				
				// review.innerHTML = sreviewContent;
				
				if(!sAttach[0]){
					console.log('이미지 없음');
				}
				else{
					console.log('이미지 있음');
					review.innerHTML += `
						<div>
							<img src="${pageContext.request.contextPath}/resources/upload/subscribe/review/\${sAttach[0].sreviewRenamedFilename}" width="300px">
						</div>
						`;
				}
				
				status.innerHTML += 
					`<input type="button" class="btn btn-116530 btn-s-order-review" id="btnWriteReview" value="리뷰쓰기" />`;
			
			},
			error : console.log
		});
		
	})
});
/* ----- 미송 끝 ----- */
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>