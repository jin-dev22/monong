<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/member/sellerMyPage.jsp"></jsp:include>
<style>
	div#prodList-container{
		max-width: 900px;
		margin: 0 auto;
	}

	.prod-order-container{
		display: flex;
		align-items: center;
		border: 1px solid black;
		border-radius: 15px; 
		margin: 20px 0;
		height: 150px;
	};
	div.prod-container-column{
		display: inline-block;
		width: 150px; 
	}
	
	div.prod-col-1{
		margin-left: 30px;
	}
	
	div.prod-col-2{
		margin: 0 50px;
		width: 50%;
		padding-left: 30px; 
	}
</style>
<div id="prodList-container">
	<form name="directProdFilterFrm" action="${pageContext.request.contextPath}/member/sellerProdOrderList.do" method="GET">
		<input type="hidden" name="prodNo" value="${param.prodNo}"/>
		<label for="startDate" class="date-label" >시작일</label>
		<input type="date" name="startDate" id="startDate" />
		<label for="endDate" class="date-label" >종료일</label>
		<input type="date" name="endDate" id="endDate" />
		<button>검색</button>
	</form>
	<span>해당 기간의 총 주문 건수는 []건 입니다.</span>
	<c:if test="${empty orderList}">	
		<div>해당상품의 주문내역이 없습니다.</div>
	</c:if>
	<c:if test="${not empty orderList}">
		<c:forEach items="${orderList}" var="order">
			<div class="prod-order-container">
				<div class="prod-container-column prod-col-1">
				</div>
				
				<div class="prod-container-column prod-col-2">
				</div>
				
				<div class="prod-container-column prod-col-3">
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>