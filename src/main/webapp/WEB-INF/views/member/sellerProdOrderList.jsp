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
            padding: 0 10px;
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
	<form name="directProdOrdFilterFrm" action="${pageContext.request.contextPath}/member/sellerProdOrderList.do" method="GET">
		<input type="hidden" name="prodNo" value="${param.prodNo}"/>
		<label for="startDate" class="date-label" >시작일</label>
		<input type="date" name="startDate" id="startDate" value="${startDate}"/>
		<label for="endDate" class="date-label" >종료일</label>
		<input type="date" name="endDate" id="endDate" value="${endDate}" />
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
	<span>해당 기간의 총 주문 건수는 ${orderList.size()}건 입니다.</span>
	<c:if test="${empty orderList}">	
		<div>해당상품의 주문내역이 없습니다.</div>
	</c:if>
	
	<br />

	<c:if test="${not empty orderList}">
		<c:forEach items="${orderList}" var="order">
			<div class="prod-order-container">
				<div class="order-container-row ord-row-1">
					<span>주문번호 ${order.dOrderNo}</span>
					<span>주문일자 : <fmt:formatDate value="${order.dOrderDate}" pattern="yyyy-MM-dd"/></span>
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
						<form class="ordStatusUpdateFrm" action="${pageContext.request.contextPath}/member/updateOrderStatus.do"
							method="POST" accept-charset="UTF-8">
							<select name="orderStatus" class="order-status-update"  onchange="chkSubmit(this.form);">
								<option value="P" ${order.dOrderStatus eq 'P' ? 'selected' : 'disabled'}>결제완료</option>
								<option value="R" ${order.dOrderStatus eq 'R' ? 'selected' : not(order.dOrderStatus eq 'P')? 'disabled' : ''}>상품준비중</option>
								<option value="C" ${order.dOrderStatus eq 'C' ? 'selected' : ''}>주문취소</option>
								<option value="D" ${order.dOrderStatus eq 'D' ? 'selected' : ''}>배송중</option>
								<option value="F" ${order.dOrderStatus eq 'F' ? 'selected' : ''}>배송완료</option>
							</select>
							<input type="hidden" name="dOrderNo" value="${order.dOrderNo}"/>
							<input type="hidden" name="dOrderMember" value="${order.customerId}"/>
							<input type="hidden" name="dProdNo" value="${param.prodNo }" />
							<input type="hidden" name="dProdName" value="${prodName}" />
							<sec:csrfInput />
						</form>
					</div>
				</div>

				<div class="order-container-row ord-row-3">
					<div class="order-address">${order.dDestAddress}, ${order.dDestAddressEx}</div>
				</div>
				<div class="order-container-row ord-row-4">
					<span class="order-req">배송요청사항 : ${order.dDeliveryRequest}</span>	
					<div>
						<span class="order-receive">수령인 : ${order.dRecipient}</span>&nbsp;&nbsp;		
						<span class="order-recPhone">${order.dOrderPhone}</span>
					</div>	
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>
<script>
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	const chkSubmit = (frm) =>{
		console.log(frm);
		const {orderStatus, dOrderNo, dOrderMember, dProdNo, dProdName} = frm;
		//console.log(orderStatus, dOrderNo, dOrderMember, dProdNo, dProdName);
		let SttsforAlert = "";
		switch(orderStatus.value){
		case 'P': SttsforAlert = "결제완료"; break;
		case 'R': SttsforAlert = "상품준비중"; break;
		case 'C': SttsforAlert = "주문취소"; break;
		case 'D': SttsforAlert = "배송중"; break;
		case 'F': SttsforAlert = "배송완료"; break;
		}
		console.log(SttsforAlert);
		if(confirm("진행상태는 변경 후 이전단계로 돌릴 수 없어요.\n주문번호["+dOrderNo.value+"]의 진행상태를 ["+SttsforAlert+"](으)로 변경하시겠어요?")){
			$.ajax({
				url : "${pageContext.request.contextPath}/member/updateDOrderStatus.do",
				headers,
				method : "POST",
				data : {orderStatus:orderStatus.value, dOrderNo:dOrderNo.value, 
						dOrderMember:dOrderMember.value, dProdNo:dProdNo.value, 
						dProdName:dProdName.value},
				success(result){
					console.log(result);
				},
				error(jqxhr, statusText, err){
					console.log(jqxhr, statusText, err);
				}
			}); 
		} 
		return;
		
	};
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>