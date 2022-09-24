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
<div id="member-direct-detail-container">
<c:if test="${not empty directOptList}">
	<c:set var="totalPrice" value="0"/>
	<c:forEach items="${directOptList}" var="dOList">
		<table id="member-orderList-tbl" class="table table-borderless text-center">
		<colgroup>
				<col style="width:200px;" />
				<col style="width:600px;"/>
				<col style="width:400px;"/>
		</colgroup>
		<thead>
		  <tr>
		    <td rowspan="2">
		    	<c:if test="${dOList.directattachs.DProductRenamedFilename != null}">
		    		<img src="${pageContext.request.contextPath}/resources/upload/product/${dOList.directattachs.DProductRenamedFilename}" alt="상품이미지"/>
		    	</c:if>
		    	<c:if test="${dOList.directattachs.DProductRenamedFilename == null}">
		    		<img src="${pageContext.request.contextPath}/resources/images/logo.PNG" alt="로고"/>
		    	</c:if>
		    </td>
		    <td>
		   <a href = "${pageContext.request.contextPath}/direct/directProductDetail.do?dProductNo=${dOList.directOptions.DProductNo}">${dOList.directProds.DProductName} - ${dOList.directOptions.DOptionName}</a></td>
		    <td rowspan="2">${dOList.directOptions.DPrice * dOList.dOptionCount} 원</td>
		  </tr>
		  <tr>
		   	 <td>수량 : ${dOList.dOptionCount}</td>
		  </tr>
		</thead>
		</table>
		<hr />
		<c:set var="totalPrice" value="${totalPrice + (dOList.directOptions.DPrice * dOList.dOptionCount)}"/>
	</c:forEach>
</c:if>
	<br /><br />
	<h3>결제정보</h3>
	<table class="table table-borderless table-striped">
		<colgroup>
			<col style="width:400px;" />
			<col style="width:auto"/>
		</colgroup>
		<thead>
		  <tr>
		    <td>상품금액</td>
		    	<td colspan="2">${totalPrice} 원</td>
		  </tr>
		</thead>
		<tbody>
		  <tr>
		    <td>배송비</td>
		    <td colspan="2">${directOrder.DTotalPrice-totalPrice} 원</td>
		  </tr>
		  <tr>
		    <td>결제금액</td>
		    <td colspan="2">${directOrder.DTotalPrice} 원</td>
		  </tr>
		  <tr>
		    <td>결제일시</td>
		    <td colspan="2">
			    <fmt:parseDate value="${directOrder.DOrderDate}" pattern="yyyy-MM-dd'T'HH:mm" var="orderDate"/>
				<fmt:formatDate value="${orderDate}" pattern="yyyy-MM-dd HH:mm"/>
		    </td>
		  </tr>
		  <tr>
		    <td>결제방법</td>
		    <td colspan="2">${directOrder.DPayments}</td>
		  </tr>
		</tbody>
	</table>
	<br /><br />
	<h3>배송정보</h3>
	<table class="table table-borderless table-striped">
		<colgroup>
			<col style="width:400px;" />
			<col style="width:auto"/>
		</colgroup>
		<thead>
		  <tr>
		    <td>수령인</td>
		    <td colspan="2">${directOrder.DRecipient}</td>
		  </tr>
		</thead>
		<tbody>
		  <tr>
		    <td>연락처</td>
		    <td colspan="2">${directOrder.DOrderPhone}</td>
		  </tr>
		  <tr>
		    <td>배송지</td>
		    <td colspan="2">${directOrder.DDestAddress} ${directOrder.DDestAddressEx}</td>
		  </tr>
		  <tr>
		    <td>요청사항</td>
		    <td colspan="2">${directOrder.DDeliveryRequest}</td>
		  </tr>
		</tbody>
	</table>
	
	<br /><br />
	<form:form
		 name="deleteMemberDirectOrderFrm"
		 action="${pageContext.request.contextPath}/member/deleteMemberDirectOrder.do"
		 method="post">
	  <input type="hidden" name="dOrderNo" value="${directOrder.DOrderNo}" />
	  <c:forEach items="${directOptList}" var="dOList">
	  	<input type="hidden" name="productNoList" value="${dOList.directOptions.DProductNo}"/>
	  </c:forEach>
	  <button type="submit" id="mypage-direct-del-btn" class="btn btn-EA5C2B" onclick="return confirm('주문을 취소하시겠습니까?')">주문취소</button>
	</form:form>
	  <br /><br />
	  <h6>주문상태가 '결제완료'일 때만 주문취소가 가능합니다 :)</h6>
</div>
<script>
const targetBtn = document.querySelector('#mypage-direct-del-btn');

window.onload = function isActiveDel(){
	const oStatus = "<c:out value='${directOrder.DOrderStatus}'/>";
	const delStatus = "P";
	console.log(oStatus);
	if(delStatus == oStatus){
		targetBtn.disabled = false;
		targetBtn.style.opacity = 1;
		targetBtn.style.cursor = 'pointer';
	}
	else{
		targetBtn.disabled = true;
		targetBtn.style.opacity = .3;
	}
	
};


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>