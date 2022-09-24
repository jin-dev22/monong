<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/member/sellerMyPage.jsp"></jsp:include>
<div id="prodList-container">
	<form name="directProdOrdFilterFrm" action="${pageContext.request.contextPath}/member/sellerDirectOrderList.do" method="GET">
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
				<c:forEach items="${order.orderProducts}" var="prod">
					<div class="product-container">
						<div class="order-prodName">${prod.dProductName}</div>
						<div class="order-options">
							<c:forEach items="${prod.orderOptions}" var="opt">
								<span>선택옵션 : ${opt.dOptionName}</span>&nbsp;&nbsp;
								<span>수량 : ${opt.dOptionCnt}</span>
								<span>주문금액 :<fmt:formatNumber value="${opt.dOptPrice * opt.dOptionCnt}" pattern="#,###" /> </span>
								<br />
							</c:forEach>
						</div>
					</div>
				</c:forEach>
						<div>총 결제금액 : <fmt:formatNumber value="${order.dTotalPrice}" pattern="#,###" /> </div>
					<div class="order-customer">주문자 아이디 : <br />${order.customerId}</div>
					<div class="order-status">
						<form class="ordStatusUpdateFrm" action="${pageContext.request.contextPath}/member/updateOrderStatus.do"
							method="POST" accept-charset="UTF-8">
							<select name="orderStatus" class="order-status-update"  onchange="chkSubmit(this.form);"
									${order.dOrderStatus eq 'C' ? 'disabled' : ''}>
								<option value="P" ${order.dOrderStatus eq 'P' ? 'selected' : ''}>결제완료</option>
								<option value="R" ${order.dOrderStatus eq 'R' ? 'selected' : ''}>상품준비중</option>
								<option value="C" ${order.dOrderStatus eq 'C' ? 'selected' : ''}>주문취소</option>
								<option value="D" ${order.dOrderStatus eq 'D' ? 'selected' : ''}>배송중</option>
								<option value="F" ${order.dOrderStatus eq 'F' ? 'selected' : ''}>배송완료</option>
							</select>
							<input type="hidden" name="dOrderNo" value="${order.dOrderNo}"/>
							<input type="hidden" name="dOrderMember" value="${order.customerId}"/>
							<c:forEach items="${order.orderProducts}" var="prod">
								<c:forEach items="${prod.orderOptions}" var="opt">
									<input type="hidden" name="dOptionNo"  value="${opt.dOptionNo}" />
									<input type="hidden" name="dOptionCount" value="${opt.dOptionCnt}" />
								</c:forEach>
							</c:forEach>
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
		<nav>
			${pagebar}
		</nav>
	</c:if>
</div>
<script>
$("#lnik-orderList").css("color","EA5C2B")

	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	const chkSubmit = (frm) =>{
		console.log(frm);
		const {orderStatus, dOrderNo, dOrderMember} = frm;
		const dOptionNoList = Array.from(frm.querySelectorAll("[name=dOptionNo]"));
		const dOptionCountList = Array.from(frm.querySelectorAll("[name=dOptionCount]"));
		const dOptionNo = dOptionNoList.reduce((arr, input)=>{
			arr.push(input.value);
			return arr;
		},[]);
		const dOptionCount = dOptionCountList.reduce((arr, input)=>{
			arr.push(input.value);
			return arr;
		},[]);
		console.log(dOptionNo, dOptionCount);
		let StatusforAlert = "";
		let cnt = 0;
		switch(orderStatus.value){
		case 'P': StatusforAlert = "결제완료"; cnt = 1; break;
		case 'R': StatusforAlert = "상품준비중"; cnt = 2; break;
		case 'C': StatusforAlert = "주문취소"; cnt = 3; break;
		case 'D': StatusforAlert = "배송중"; cnt = 4; break;
		case 'F': StatusforAlert = "배송완료"; cnt = 5; break;
		}
		console.log(StatusforAlert);
		if(confirm("진행상태는 변경 후 이전단계로 돌릴 수 없어요.\n주문번호["+dOrderNo.value+"]의 진행상태를 ["+StatusforAlert+"](으)로 변경하시겠어요?")){
			const opts =  Array.from(orderStatus.getElementsByTagName("option"));
			console.log(opts);
			//return;
			$.ajax({
				url : "${pageContext.request.contextPath}/member/updateDOrderStatus.do",
				headers,
				method : "POST",
				data : {orderStatus:orderStatus.value, dOrderNo:dOrderNo.value, 
						memberId:dOrderMember.value, dOptionNo, dOptionCount},
				success(result){
					console.log(result);
					if(result>0){
						opts.forEach((opt, i)=>{
							if(i < cnt){
								opt.disabled = true;
								console.log(opt.disabled);
							}
						});
					};
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