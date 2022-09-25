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
<jsp:include page="/WEB-INF/views/admin/adminMyPage.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminSubscription.css" />

<div class="btn-fillter-container">
	<div>
		<button type="button" class="btn btn-116530-reverse" onclick="history.go(-1);">이전</button>
	</div>
</div>

<div id="admin-subscriptionList-container" class="mt-5 mx-auto text-center">
<c:if test="${empty subscriptionListDetail}">
	<span>조회결과가 없어요.&#128546;</span>
</c:if>
<c:if test="${not empty subscriptionListDetail}">
<p style="text-align: right;">(총 ${totalContent} 건)</p>
	<c:forEach items="${subscriptionListDetail}" var="subDetail" varStatus="vs">
		<table class="table admin-subscriptionList">
			<thead>
				<tr class="admin-subscriptionList-table-header">
					<c:set value="${subDetail.SOrderNo}" var="orderNo"/>
					<th colspan="2">주문번호 - ${fn:substring(orderNo, 2, 15)} (${subDetail.STimes}회차)</th>
					<th>결제일: ${subDetail.SOrderDate}</th>
					<th>배송일: ${subDetail.soDeliveryDate}</th>
				</tr>
			</thead>
			<tbody>
				<tr data-subscription-no="${subDetail.SOrderNo}">
					<th scope="row" rowspan="3">${vs.count}</th>
					<td>
						정기구독박스 - 
						<c:if test="${subDetail.soProductCode eq 'SP1'}">싱글</c:if>
						<c:if test="${subDetail.soProductCode eq 'SP2'}">레귤러</c:if>
						<c:if test="${subDetail.soProductCode eq 'SP3'}">라지</c:if>
					</td>
					<td>
						제외채소:
						<c:if test="${subDetail.soExcludeVegs eq null}">없음</c:if> 
						<c:if test="${subDetail.soExcludeVegs ne null}">${subDetail.soExcludeVegs}</c:if>
					</td>
					<td>
						<select disabled name=sub-deliveryStatus id="sub-deliveryStatus">
							<option value="상품준비중" ${subDetail.SOrderStatus eq '상품준비중' ? 'selected' : ''}>상품준비중</option>
							<option value="배송중" ${subDetail.SOrderStatus eq '배송중' ? 'selected' : ''}>배송중</option>
							<option value="배송완료" ${subDetail.SOrderStatus eq '배송완료' ? 'selected' : ''}>배송완료</option>
						</select>
						<c:if test="${subDetail.SOrderStatus eq '배송완료'}">
							<span>: ${subDetail.soDeliveryCompletedDate}</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>수령자: ${subDetail.soRecipient}</td>
					<td colspan="2">배송지: ${subDetail.soAddress} ${subDetail.soAddressEx != null ? subDetail.soAddressEx : ''}</td>
				</tr>
				<tr>
					<c:set value="${subDetail.soPhone}" var="phone"></c:set>
					<td>연락처: ${fn:substring(phone, 0, 3)}-****-${fn:substring(phone, 7, 11)}</td>
					<td colspan="2"> 요청사항: ${subDetail.soDeliveryRequest != null ? subDetail.soDeliveryRequest : ''}</td>
				</tr>
			</tbody>
		</table>
	</c:forEach>
</c:if>
</div>
<nav class="pagebar">
	${pagebar}
</nav>
<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>