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
            border: 1px solid grey;
            margin: 20px 0;
            min-height: 200px;
        };
        
        div.order-container-row.ord-row-1 >*{
            display: inline-block;
        }
        div.order-container-row.ord-row-1{
            background-color: lightgrey;
            display: flex;
            justify-content: space-between;
        }
        div.order-container-row.ord-row-2{
            display: flex;
            align-items: center; 
            justify-content: space-between;
        }
        div.order-container-row.ord-row-2 > *{
            display: inline-block;
            min-width: 100px;
            margin: 10px 15px;
        }
        div.order-prodNam{
            display: inline-block;
            width: 150px;
        }
        div.order-options{
            display: inline-block;
        }

        div.order-container-row.ord-row-4 >*{
            display: inline-block;
            min-width: 100px;
            margin: 10px 15px;
        }
        div.order-container-row.ord-row-4{
            display: flex;
            justify-content: space-between;
        }
        div.order-address{
            margin: 10px 15px;
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
	<span>해당 기간의 총 주문 건수는 ${orderList.size()}건 입니다.</span>
	<c:if test="${empty orderList}">	
		<div>해당상품의 주문내역이 없습니다.</div>
	</c:if>
	
	<br />
	############화면 테스트용
			<div class="prod-order-container">
        <div class="order-container-row ord-row-1">
            <span>주문번호 qe21123123</span>
            <span>주문일자 : 2022-09-01</span>
        </div>
        <div class="order-container-row ord-row-2">
            <div class="order-prodName">상품명</div>
            <div class="order-options">
                <!-- 반복문forEach처리할것 -->
                <span>선택옵션 : 선택1kg</span>
                <span>수량 : 3</span>
                <br>
                <span>선택옵션 : 선택3kg</span>
                <span>수량 : 1</span>
                <!-- ~반복문end -->
                <div>주문금액 : 100,000</div>
            </div>
            <div class="order-customer">주문자 아이디</div>
            <div class="order-status">
                <select class="orderStatusChange">
                    <option value="P" ${order.dOrderStatus eq 'P' ? 'selected' : ''}>결제완료</option>
                    <option value="R" ${order.dOrderStatus eq 'R' ? 'selected' : ''}>상품준비중</option>
                    <option value="C" ${order.dOrderStatus eq 'C' ? 'selected' : ''}>주문취소</option>
                    <option value="D" ${order.dOrderStatus eq 'D' ? 'selected' : ''}>배송중</option>
                    <option value="F" ${order.dOrderStatus eq 'F' ? 'selected' : ''}>배송완료</option>
                </select>
            </div>
        </div>
        <div class="order-container-row ord-row-3">
            <div class="order-address">배송지주소, 배송지 주소상세</div>
        </div>
        <div class="order-container-row ord-row-4">
            <span class="order-req">배송요청사항 : 부재시 문앞에 두세요.</span>		
            <div>
                <span class="order-receive">수령인 : 수진수진수진</span>&nbsp;&nbsp;
                <span class="order-recPhone">01012341234</span>    
            </div>
            
        </div>

    </div>
	
	
	<c:if test="${not empty orderList}">
		<c:forEach items="${orderList}" var="order">
			<div class="prod-order-container">
				<div class="order-container-row ord-row-1">
					<span>주문번호 ${order.dOrderNo}</span>
					<span>주문일자 : ${order.dOrderDate}</span>
				</div>
				<div class="order-container-row ord-row-2">
					<div class="order-prodName">${prodName}</div>
					<div class="order-options">
						<!-- 반복문forEach처리할것 -->
						<span>선택옵션 : ${order.dOptionName}</span>
						<span>수량 : ${order.dOptionCount}</span>
						<!-- ~반복문end -->
						<div>주문금액 : ${order.dTotalPrice}</div>
					</div>
					<div class="order-customer">${order.customerId}</div>
					<div class="order-status">
						<select class="orderStatusChange">
							<option value="P" ${order.dOrderStatus eq 'P' ? 'selected' : ''}>결제완료</option>
							<option value="R" ${order.dOrderStatus eq 'R' ? 'selected' : ''}>상품준비중</option>
							<option value="C" ${order.dOrderStatus eq 'C' ? 'selected' : ''}>주문취소</option>
							<option value="D" ${order.dOrderStatus eq 'D' ? 'selected' : ''}>배송중</option>
							<option value="F" ${order.dOrderStatus eq 'F' ? 'selected' : ''}>배송완료</option>
						</select>
					</div>
				</div>
				<div class="order-container-row ord-row-3">
					<div class="order-address">${order.dDestAddress}, ${order.dDestAddressEx}</div>
					<span>배송요청사항 : ${order.dDeliveryRequest}</span>		
					<span>수령인 : ${order.dRecipient}</span>		
					<span>${order.dOrderPhone}</span>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>