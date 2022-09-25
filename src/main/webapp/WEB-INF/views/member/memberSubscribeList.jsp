<%@page import="java.time.LocalDate"%>
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
.member-subscription-tbl th {
	line-height: 35px;
}
.btn-s-order-review{
	margin-left: 10px;
}
</style>
<div id="member-subscribetionList-container" class="mx-auto mt-5 text-center">
<c:if test="${empty subList}">
	<h3>구독 히스토리가 없습니다.</h3>
</c:if>
<c:if test="${not empty subList}">
	<table class="table table-borderless text-center member-subscription-tbl">
		<c:forEach items="${subList}" var="subList">
			<thead>
			  <tr class="table-active">
			    <th>${subList.SOrderDate}</th>
			    <th colspan="2"><a class="s-order-no" href="${pageContext.request.contextPath}/member/memberSubscribeDetail.do?sOrderNo=${subList.SOrderNo}">${subList.SOrderNo}</a></th>
<%
	LocalDate today = LocalDate.now();
	pageContext.setAttribute("today", today);
%>
			    <th class="s-order-status" data-order-no="${subList.SOrderNo}">
			    	${subList.SOrderStatus}
					<c:if test="${subList.SOrderStatus eq '배송완료' && empty subList.SReviewNo && subList.reviewEndDate > today}">
					 	<input type="button" class="btn btn-116530 btn-s-order-review" id="btnWriteReview" value="리뷰쓰기" />
					</c:if>	    
	    		</th>
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

<nav id="pagebar">
	${pagebar}
</nav>
</div>
<form 
	action="<%= request.getContextPath() %>/member/memberSubscribeReviewForm.do"
	method="get" 
	name="subscribeOrderReviewFrm">
	<input type="hidden" name="sOrderNo"/>
</form>

<script>
const btnWriteReview = document.querySelectorAll("#btnWriteReview");
console.log('btnWriteReview', btnWriteReview);

if(btnWriteReview !== null){
	btnWriteReview.forEach(function(btn, index){
		btn.addEventListener('click', (e) => {
			const frm = document.subscribeOrderReviewFrm;
			const sOrderNo = btn.parentElement.dataset.orderNo;
			console.log('sOrderNo', sOrderNo);
			
			frm.sOrderNo.value = sOrderNo;
			
			const title = "ReviewPopupFrm";
			const spec = "width=520px, height=800px";
			const popup = open("", title, spec);
			
			frm.target = title;
			frm.submit();
		});
	})
}

$("#lnik-sOList").css("color","EA5C2B")
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>