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
		<button type="button" class="btn btn-116530-reverse" onclick="location.href=`${pageContext.request.contextPath}/admin/subscriptionList.do`;">전체 조회</button>
		<button type="button" class="btn btn-116530" onclick="location.href=`${pageContext.request.contextPath}/admin/subscriptionOrderList.do`;">출고 관리</button>
	</div>
	<c:if test="${deliveryStatus eq '배송완료'}">
		<form name="searchDataFrm" action="${pageContext.request.contextPath}/admin/subscriptionOrderList.do"" method="GET">
			<label for="searchStartDate">기간조회: </label>
			<input type="date" name="searchStartDate" id="searchStartDate" />
			<label for="searchEndDate">-</label>
			<input type="date" name="searchEndDate" id="searchEndDate" />
			<input type="button" class="btn btn-EA5C2B-reverse" onclick="searchData()" value="검색" />
			<input type="hidden" name="deliveryStatus" value="배송완료" />
		</form>
	</c:if>
	<form name="subOrderDeliveryFilterFrm" class="btn-fillter-wrapper" action="${pageContext.request.contextPath}/admin/subscriptionOrderList.do" method="GET">
		<select id="deliveryStatusFilter" name="deliveryStatus" class="form-select" aria-label="Default select example" onchange="this.form.submit()" >
			<option value="상품준비중" ${deliveryStatus eq '상품준비중' ? 'selected' : ''}>상품준비중</option>
			<option value="배송중" ${deliveryStatus eq '배송중' ? 'selected' : ''}>배송중</option>
			<option value="배송완료" ${deliveryStatus eq '배송완료' ? 'selected' : ''}>배송완료</option>
		</select>
	</form>
</div>
<c:if test="${searchEndDate ne null && searchStartDate ne null}">
	<span>조회일자: ${searchStartDate} ~ ${searchEndDate}</span>
</c:if>
<div id="admin-subscriptionList-container" class="mt-5 mx-auto text-center">
<c:if test="${empty subscriptionOrderList}">
	<span>검색 결과가 없습니다.</span>
</c:if>
<c:if test="${not empty subscriptionOrderList}">
	<c:forEach items="${subscriptionOrderList}" var="subOrder" varStatus="vs">
		<table class="table admin-subscriptionList">
			<thead>
				<tr class="admin-subscriptionList-table-header">
					<c:set value="${subOrder.SOrderNo}" var="orderNo"/>
					<th colspan="2">주문번호 - ${fn:substring(orderNo, 2, 15)} (${subOrder.STimes}회차)</th>
					<th>결제일: ${subOrder.SOrderDate}</th>
					<th>배송일: ${subOrder.soDeliveryDate}</th>
				</tr>
			</thead>
			<tbody>
				<tr data-subscription-no="${subOrder.SOrderNo}">
					<th scope="row" rowspan="3">${vs.count}</th>
					<td>
						정기구독박스 - 
						<c:if test="${subOrder.soProductCode eq 'SP1'}">싱글</c:if>
						<c:if test="${subOrder.soProductCode eq 'SP2'}">레귤러</c:if>
						<c:if test="${subOrder.soProductCode eq 'SP3'}">라지</c:if>
					</td>
					<td>
						제외채소:
						<c:if test="${subOrder.soExcludeVegs eq null}">없음</c:if> 
						<c:if test="${subOrder.soExcludeVegs ne null}">${subOrder.soExcludeVegs}</c:if>
					</td>
					<td>
						<select name=sub-deliveryStatus id="sub-deliveryStatus">
							<option value="상품준비중" ${subOrder.SOrderStatus eq '상품준비중' ? 'selected' : ''}>상품준비중</option>
							<option value="배송중" ${subOrder.SOrderStatus eq '배송중' ? 'selected' : ''}>배송중</option>
							<option value="배송완료" ${subOrder.SOrderStatus eq '배송완료' ? 'selected' : ''}>배송완료</option>
						</select>
						<span>: ${subOrder.soDeliveryCompletedDate}</span>
					</td>
				</tr>
				<tr>
					<td>수령자: ${subOrder.soRecipient}</td>
					<td colspan="2">배송지: ${subOrder.soAddress} ${subOrder.soAddressEx != null ? subOrder.soAddressEx : ''}</td>
				</tr>
				<tr>
					<c:set value="${subOrder.soPhone}" var="phone"></c:set>
					<td>연락처: ${fn:substring(phone, 0, 3)}-****-${fn:substring(phone, 7, 11)}</td>
					<td colspan="2"> 요청사항: ${subOrder.soDeliveryRequest != null ? subOrder.soDeliveryRequest : ''}</td>
				</tr>
			</tbody>
		</table>
	</c:forEach>
</c:if>
</div>
<c:if test="${subscriptionOrderList ne null}">
	<nav id="pagebar">
		${pagebar}
	</nav>
</c:if>
<script>
function searchData(){
	const frm = document.searchDataFrm;
	const startDate = frm.searchStartDate.value;
	const endDate = frm.searchEndDate.value;
	console.log(startDate);
	console.log(endDate);
	if(!startDate){
		alert("기간을 입력해주세요.");
		return;
	}
	frm.submit();
};
window.onload = function(){
	const optionList = document.querySelectorAll("#sub-deliveryStatus option").forEach((option) => {
		const isSelected = option.selected;
		// 배송완료된 주문건은 상태 수정 불가
		if(isSelected && option.value == '배송완료'){
			option.parentElement.disabled = 'true';
			
			// 배송완료시에만 기간 조회 가능
			let today = new Date();
			const endDate = document.querySelector("#searchEndDate");
			endDate.valueAsDate = today;
			
		}
		// 상품준비중인 상태에서는 배송완료 비활성화
		if(isSelected && option.value == '상품준비중'){
			option.nextElementSibling.nextElementSibling.disabled = 'true';
		}
		// 배송중인 상태에서는 상품준비중 비활성화
		if(isSelected && option.value == '배송중'){
			option.previousElementSibling.disabled = 'true';
		}
	});
};

const inputSelectors = document.querySelectorAll("#sub-deliveryStatus").forEach((inputSelector) => {
	inputSelector.addEventListener('change', (e) => {
		let changeDStatus = e.target.value;
		const parent = e.target.parentElement.parentElement;
		const subOrderNo = parent.dataset.subscriptionNo;
		
		const headers = {};
		headers['${_csrf.headerName}'] = '${_csrf.token}';
		
		$.ajax({
			url: `${pageContext.request.contextPath}/admin/subDeliveryUpdate.do`,
			data: {changeDStatus, subOrderNo},
			headers,
			method: 'POST',
			success(response){
				console.log(response);
				if(response == 1){
					window.location.reload();
				}
			},
			error: console.log
		});
	});
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>