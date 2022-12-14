<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/member/sellerMyPage.jsp"></jsp:include>
<div id="prodList-container">
	<form name="directProdOrdFilterFrm" action="${pageContext.request.contextPath}/member/sellerProdOrderList.do" method="GET">
		<input type="hidden" name="prodNo" value="${param.prodNo}"/>
		<label for="startDate" class="date-label" >시작일</label>
		<input type="date" name="startDate" id="startDate" value="${startDate}"/>
		<label for="endDate" class="date-label" >종료일</label>
		<input type="date" name="endDate" id="endDate" value="${endDate}" />
		&nbsp;&nbsp;&nbsp;
		<input type="submit" value="검색" />
	</form>
	<script>
		const frm = document.directProdOrdFilterFrm;
		//console.log(frm);
		frm.addEventListener('submit', (e)=>{
			e.preventDefault();
			const startDate = frm.startDate;
			const endDate = frm.endDate;
			console.log(startDate.value,"~",endDate.value);
			if((startDate.value == "" && endDate.value != "")||(startDate.value != ""&& endDate.value == "")){
				alert("검색 시작일과 종료일을 모두 입력해주세요.");
				return;
			}
			if(startDate.value > endDate.value){
				alert("종료일은 시작일보다 이전일 수 없어요.");
				return;
			};
			frm.submit();
		});
	</script>
	<span>해당 기간의 총 주문 건수는 ${totalContent}건 입니다.</span>
	<c:if test="${empty orderList}">	
		<div>해당상품의 주문내역이 없어요.</div>
	</c:if>
	
	<br />

	<c:if test="${not empty orderList}">
		<c:forEach items="${orderList}" var="order">
			<div class="prod-order-container">
				<div class="order-container-row ord-row-1">
					<span class="order-head">주문번호 ${order.dOrderNo}</span>
					<span class="order-head">주문일자 : <fmt:formatDate value="${order.dOrderDate}" pattern="yyyy-MM-dd"/></span>
				</div>
				<div class="order-container-row ord-row-2">
					<div class="order-prodName">${prodName}</div>
					<div class="order-options">
						<c:forEach items="${order.dProdOptions}" var="opt">
							<span>선택옵션 : ${opt.dOptionName}</span>&nbsp;&nbsp;
							<span>수량 : ${opt.dOptionCount}</span>
							<br />
						</c:forEach>
						<div>주문금액 : <fmt:formatNumber value="${order.dTotalPrice}" pattern="#,###" /> </div>
					</div>
					<div class="order-customer">주문자 아이디 : <br />${order.customerId}</div>
					<div class="order-status">
						<select name="orderStatus" class="order-status-update" disabled>
							<option value="P" ${order.dOrderStatus eq 'P' ? 'selected' : ''}>결제완료</option>
							<option value="R" ${order.dOrderStatus eq 'R' ? 'selected' : ''}>상품준비중</option>
							<option value="C" ${order.dOrderStatus eq 'C' ? 'selected' : ''}>주문취소</option>
							<option value="D" ${order.dOrderStatus eq 'D' ? 'selected' : ''}>배송중</option>
							<option value="F" ${order.dOrderStatus eq 'F' ? 'selected' : ''}>배송완료</option>
						</select>
						<c:forEach items="${order.dProdOptions}" var="opt">
							<input type="hidden" name="dOptionNo" value="${opt.dOptionNo}" />
							<input type="hidden" name="dOptionCount" value="${opt.dOptionCount}" />
						</c:forEach>
					</div>
				</div>
			</div>
		</c:forEach>
		<nav>
			${pagebar}
		</nav>
	</c:if>
</div>
<script>	
	$("#lnik-prodList").css("color","EA5C2B");
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>