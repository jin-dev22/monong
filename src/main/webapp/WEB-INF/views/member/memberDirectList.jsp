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
<div id="member-orderList-container" class="mx-auto mt-5 text-center">
<c:if test="${empty directOrderList}">
	<h3>주문 내역이 없습니다.</h3>
</c:if>
<c:if test="${not empty directOrderList}">
	<c:forEach items="${directOrderList}" var="oList" varStatus="vs">			
		<table id="member-orderList-tbl" class="table table-borderless text-center">
			<thead>
			  <tr class="table-active">
			    <th>
			     ${fn:substring(oList.dOrderDate,0,10)}
			    </th>
			    <th></th>
			    <th></th>
			    <th></th>
			    <th><a href="${pageContext.request.contextPath}/member/memberDirectDetail.do?dOrderNo=${oList.dOrderNo}">주문 상세보기</a></th>
			  </tr>
			</thead>
			<tbody>
			  <tr>
			    <td rowspan="3">
				  	<c:if test="${oList.attach.DProductRenamedFilename != null}">
				    	<img src="${pageContext.request.contextPath}/resources/upload/product/${oList.attach.DProductRenamedFilename}" alt="" />
				    
				    </c:if>
				  <c:if test="${oList.attach.DProductRenamedFilename == null}">
					    <img src="${pageContext.request.contextPath}/resources/images/logo.PNG" alt="" />
				  </c:if>
				  </td>
			    <td>주문상품</td>
			    <td>${oList.prod.DProductName} 외</td>
			    <td></td>
			    <td>
			    </td>
			  </tr>
			  <tr>
			    <td>주문번호</td>
			    <td>${oList.dOrderNo}</td>
			    <td></td>
			    <td class="member-mypage-active-color">
			    	<c:choose>
				    	<c:when test="${oList.dOrderStatus == 'P'}">
				    		<c:out value="결제완료"/>
				    	</c:when>
				    	<c:when test="${oList.dOrderStatus == 'R'}">
				    		<c:out value="상품준비중"/>
				    	</c:when>
				    	<c:when test="${oList.dOrderStatus == 'C'}">
				    		<c:out value="주문취소"/>
				    	</c:when>
				    	<c:when test="${oList.dOrderStatus == 'D'}">
				    		<c:out value="배송중"/>
				    	</c:when>
				    	<c:otherwise>
				    		<c:out value="배송완료"/>
				    	</c:otherwise>
				    </c:choose>
			    </td>
			  </tr>
			  <tr>
			    <td>결제수단</td>
			    <td>${oList.dPayments}</td>
			    <td></td>
			    <td>
			    </td>
			  </tr>
			  <tr>
			    <td></td>
			    <td>결제금액</td>
			    <td>${oList.dTotalPrice} 원</td>
			    <td></td>
			    <td></td>
			  </tr>
			</tbody>
		</table>
		 
		</c:forEach>  
	<nav>
	${pagebar}
	</nav>
</c:if>
</div>
<script>
$("#lnik-dOList").css("color","EA5C2B");

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>