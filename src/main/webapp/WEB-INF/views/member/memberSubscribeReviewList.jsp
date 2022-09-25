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
.m-s-review-table{
	text-align: center;
}

.m-s-review-table th{
	background-color: #F6D860;
}

.table-tr.active{
	background-color: #f2f2f2;
	border-top: 1px solid lightgrey;
	border-bottom: 1px solid lightgrey;
}

.m-s-review-content{
	width: 745px;
	padding-left: 70px;
	padding-right: 70px;
}

.m-s-review-content span:hover{
	cursor: pointer;
}

.table-m-s-review-star{
	width: 200px;
	padding-left: 70px;
	padding-right: 70px;
}

.m-s-review-star{
	color: #aaa9a9; 
	position: relative;
	width: max-content;
}

.m-s-review-star-filled{
    color: #F6D860;
    /* padding: 0; */
    position: absolute;
    /* z-index: 1; */
    /* display: flex; */
    overflow: hidden;
}

.btn-wrapper{
	margin-top: 10px;
}

.m-s-review-detail-imgs{
    display: inline-block;
}

.m-s-review-detail-imgs img{
    display: inline-block;
    width: 150px;
}
</style>
<c:if test="${empty sReviewList}">
	<br /><br />
	<div class="mx-auto text-center">
		<h3>작성완료된 정기구독 후기가 없어요 :(</h3>
		<span>후기를 입력한 후에 히스토리를 확인하실 수 있어요!</span>
	</div>
</c:if>
<c:if test="${not empty sReviewList}">
	<table class="table table-borderless m-s-review-table">
		<thead>
			<tr>
				<th>구독회차</th>
				<th>후기내용</th>
				<th class="table-m-s-review-star">별점</th>			    
				<th>작성일</th>			    
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${sReviewList}" var="sReview">
			<tr class="table-tr">
				<td>${sReview.STimes}회차</td>
				<td class="m-s-review-content" data-s-review-no="${sReview.SReviewNo}" style="padding-left: 128px; padding-right: 128px;">
					<span onclick="sReviewDetail(this)">
					<c:choose>
					 	<c:when test="${fn:length(sReview.SReviewContent) gt 38}">
					 		${fn:substring(sReview.SReviewContent, 0, 38)}...
					 	</c:when>
					 	<c:otherwise>
					 		${sReview.SReviewContent}
					 	</c:otherwise>
					</c:choose>
					</span>
					<div class="content-container"></div>
				</td>
				<td class="table-m-s-review-star" style="padding-left: 70px; padding-right: 70px;">
				<div class="m-s-review-star">
					<span class="m-s-review-star-filled" style="width:${sReview.SReviewStar*20}%">★★★★★</span>
					<span class="m-s-review-unfilled">★★★★★</span>
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
	<nav class="m-s-review-page-bar">
	${pagebar}
	</nav>
</c:if>


<form 
	action="<%= request.getContextPath() %>/member/memberSubscribeReviewUpdateForm.do"
	method="get" 
	name="subscribeReviewUpdateFrm">
	<input type="hidden" name="sReviewNo"/>
</form>

<script>
const sReviewDetail = (review) => {
	const sReviewNo = review.parentElement.dataset.sReviewNo;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/member/memberSubscribeReviewDetail.do",
		data: {sReviewNo},
		method : "GET",
		success(result){
			console.log(result);
			const {sreviewContent, sattachments} = result;
			
			review.parentElement.classList.toggle('active');
			review.parentElement.parentElement.classList.toggle('active');
			
			if(review.parentElement.classList.contains('active')){
				review.innerHTML = `\${sreviewContent}`;
				
				sattachments.forEach(function(attach){
					if(!attach){
						console.log('이미지 없음');
					}
					else{
						console.log('이미지 있음');
						review.nextElementSibling.innerHTML += `
							<div class="m-s-review-detail-imgs">
								<img src="${pageContext.request.contextPath}/resources/upload/subscribe/review/\${attach.sreviewRenamedFilename}" width="300px">
							</div>
							`;
					}
				});
				
				review.nextElementSibling.innerHTML += `<div class="btn-wrapper">
						<input type="button" class="btn btn-116530" value="수정하기" onclick="btnUpdateReview(this)" data-review-no="\${sReviewNo}"/>
						<input type="button" class="btn btn-EA5C2B" value="삭제하기" onclick="btnDeleteReview(this)" data-review-no="\${sReviewNo}"/>
					</div>`;
			}
			
			else {
				review.nextElementSibling.innerHTML = '';
				review.innerHTML = `\${sreviewContent.length > 38 ? sreviewContent.substr(0, 38) + '...': sreviewContent}`;
			}
			
		},
		error : console.log
	});
};

const btnUpdateReview = (btn) => {
	const frm = document.subscribeReviewUpdateFrm;
	const sReviewNo = btn.dataset.reviewNo;
	console.log('sReviewNo', sReviewNo);
	
	frm.sReviewNo.value = sReviewNo;
	
	const title = "ReviewPopupFrm";
	const spec = "width=520px, height=800px";
	const popup = open("", title, spec);
	
	frm.target = title;
	frm.submit();
};

const btnDeleteReview = (btn) => {
	if(confirm('정말 삭제하시겠습니까?')){
		const sReviewNo = btn.dataset.reviewNo;
		console.log('sReviewNo', sReviewNo);
	
		$.ajax({
			url : "${pageContext.request.contextPath}/member/memberSubscribeReviewDelete.do",
			data: {sReviewNo},
			method : "POST",
			beforeSend : function(xhr){  
				            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			       		 },
			success(result){
				alert('후기를 성공적으로 삭제하였습니다.');
				location.reload();
			},
			error : console.log
		});
	
	}
};

$("#navbarDropdown").css("color","EA5C2B");
$("#lnik-sReviewList").css("color","EA5C2B");
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>