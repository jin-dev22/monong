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
<div id="member-subscribetionList-container" class="mx-auto mt-5 text-center">
<c:if test="${empty subList}">
	<h3>구독 히스토리가 없습니다.</h3>
</c:if>
<c:if test="${not empty subList}">
		<table id="member-subScription-tbl" class="table table-borderless text-center">
	<c:forEach items="${subList}" var="subList">
			<thead>
			  <tr class="table-active">
			    <th>${subList.SOrderDate}</th>
			    <th colspan="2"><a class="s-order-no" href="${pageContext.request.contextPath}/member/memberSubscribeDetail.do?sOrderNo=${subList.SOrderNo}">${subList.SOrderNo}</a></th>
			    <th class="s-order-status" data-review-no="${subList.SReviewNo}">${subList.SOrderStatus}</th>			    
			  </tr>
			</thead>
			<tbody>
			  <tr>
			    <td>정기구독 ${subList.STimes}회차</td>
			    <td>배송주기: ${subList.soDeliveryCycle}주 </td>
			    <td>제외채소 : ${subList.soExcludeVegs != null ? subList.soExcludeVegs : '없음'}</td>
			    <td>${subList.SPrice}원</td>
			  </tr>
			</tbody>
		<input type="hidden" class="s-review-no" value="${subList.SReviewNo}"/>
	</c:forEach>
		</table>
</c:if>
</div>
<form 
	action="<%= request.getContextPath() %>/member/memberSubscribeReviewForm.do"
	method="get" 
	name="subscribeOrderReviewFrm">
	<input type="hidden" name="sOrderNo"/>
</form>

<style>
.btn-s-order-review{
	margin-left: 10px;
}
</style>
<script>
const sOrderStatus = document.querySelectorAll(".s-order-status");
console.log('sOrderStatus', sOrderStatus);

sOrderStatus.forEach(function(status){
	console.log('status', status);
	console.log('reviewNo', status.dataset.reviewNo);
	const reviewNo = status.dataset.reviewNo;
	
	if(status.innerHTML === "배송완료" && reviewNo === ""){
		status.innerHTML += 
				`<input type="button" class="btn btn-116530 btn-s-order-review" id="btnWriteReview" value="리뷰쓰기" />`;
				
		document.querySelector("#btnWriteReview").addEventListener('click', (e) => {
			const sOrderNo = document.querySelector(".s-order-no").innerHTML;
			const frm = document.subscribeOrderReviewFrm;
			frm.sOrderNo.value = sOrderNo;
			
			const title = "ReviewPopupFrm";
			const spec = "width=520px, height=800px";
			const popup = open("", title, spec);
			
			frm.target = title;
			frm.submit();
		});

	}
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>