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
<jsp:include page="/WEB-INF/views/admin/adminMyPage.jsp">
	<jsp:param name="title" value="모농모농"></jsp:param>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSubscription.css" />

<button type="button" class="btn btn-116530-reverse" onclick="location.href=`${pageContext.request.contextPath}/admin/subscriptionList.do`;">전체 조회</button>
<button type="button" class="btn btn-116530" onclick="location.href=`${pageContext.request.contextPath}/admin/subscriptionOrderList.do`;">출고 관리</button>
<h1>쿼리문 변경예정</h1>
<div id="admin-subscriptionList-container" class="mt-5 mx-auto text-center">
<c:forEach items="${subscriptionList}" var="sub" varStatus="vs">
	<table class="table">
		<thead>
			<tr class="admin-subscriptionList-table-header">
				<th scope="col" colspan="2">주문번호 - ${sub.SNo}</th>
				<th scope="col">다음 결제일: ${sub.SPaymentDate}</th>
				<th scope="col">다음 배송일: ${sub.SNextDeliveryDate}</th>
			</tr>
		</thead>
		<tbody>
			<tr data-subscription-no="${sub.SNo}">
				<th scope="row" rowspan="3">${vs.count}</th>
				<td>
					정기구독박스 - 
					<c:if test="${sub.SProductCode eq 'SP1'}">싱글</c:if>
					<c:if test="${sub.SProductCode eq 'SP2'}">레귤러</c:if>
					<c:if test="${sub.SProductCode eq 'SP3'}">라지</c:if>
				</td>
				<td>
					제외채소:
					<c:if test="${sub.SExcludeVegs eq null}">없음</c:if> 
					<c:if test="${sub.SExcludeVegs ne null}">${sub.SExcludeVegs}</c:if>
				</td>
				<td>배송주기: ${sub.SDeliveryCycle}</td>
			</tr>
			<tr>
				<td>수령자: ${sub.SRecipient}</td>
				<td>배송지: ${sub.SAddress} ${sub.SAddressEx}</td>
				<c:set value="${sub.SPhone}" var="phone"></c:set>
				<td>연락처: ${fn:substring(phone, 0, 3)}-****-${fn:substring(phone, 7, 11)} 
				</td>
			</tr>
		</tbody>
	</table>
</c:forEach>
</div> 
<nav>
	${pagebar}
</nav>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>