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
<div id="member-subscribetionList-container" class="mx-auto mt-5 text-center">

	<table id="member-subDetail-tbl" class="table table-borderless table-striped text-center">
		<thead>
		  <tr>
		    <th>
			    ${subDetail.SOrderDate}
		    </th>
		    <th>${subDetail.SOrderNo}</th>
		    <th>${subDetail.SOrderStatus}</th>
		  </tr>
		</thead>
		<tbody>
		  <tr>
		    <td>정기구독 ${subDetail.sTimes}회차</td>
		    <td>${subDetail.prod.SProductName} ${subDetail.prod.SProductInfo}</td>
		    <td>제외채소 : 
		    <c:if test="${subDetail.soExcludeVegs == null}">
		    없음
		    </c:if>
		    <c:if test="${subDetail.soExcludeVegs != null}">
		    ${subDetail.soExcludeVegs}
		    </c:if>
		    </td>
		  </tr>
		</tbody>
	</table>
	
	<div id="member-pay-container">
		<h3>결제내역</h3>
		<hr />
		<table class="table table-borderless">
			<thead>
			  <tr>
			    <th>주문번호</th>
			    <th></th>
			    <th>주문일자</th>
			  </tr>
			</thead>
			<tbody>
			  <tr>
			    <td>${subDetail.sOrderNo}</td>
			    <td></td>
			    <td>
			    ${fn:substring(subDetail.sOrderDate,0,16)}
			    </td>
			  </tr>
			  <tr>
			    <td></td>
			    <td></td>
			    <td></td>
			  </tr>
			  <tr>
			    <th>배송정보</th>
			    <td></td>
			    <td>배송상태</td>
			  </tr>
			  <tr>
			    <td>수령인 : ${subDetail.soRecipient}</td>
			    <td></td>
			    <td><strong>${subDetail.sOrderStatus}</strong></td>
			  </tr>
			  <tr>
			  	<td colspan="2">연락처 : ${subDetail.soPhone}</td>
			  	<td class="text-success">
			  	<c:if test="${subDetail.sOrderStatus eq '배송완료'}">
			  	<strong>(배송완료일 : ${fn:substring(subDetail.soDeliveryCompletedDate,0,10)})</strong>
			    </c:if>
			  	</td>
			  </tr>
			  <tr>
			    <td colspan="2">배송지 : ${subDetail.soAddress} ${subDetail.soAddressEx}</td>
			    <td></td>
			  </tr>
			  <tr>
			    <td colspan="2">요청사항 : ${subDetail.soDeliveryRequest}</td>
			    <td></td>
			  </tr>
			  <tr>
			    <td></td>
			    <td></td>
			    <td></td>
			  </tr>
			  <tr>
			    <th>결제정보</th>
			    <td></td>
			    <td>결제일자 : ${subDetail.sub.SPaymentDate}</td>
			  </tr>
			  <tr>
			    <td>카드</td>
			    <td></td>
			    <td></td>
			  </tr>
			</tbody>
		</table>
	</div>
	<hr />
	<h4>구독금액 : ${subDetail.sPrice} 원</h4>
	<h4>+</h4>
	<h4>배송비 :  ${subDetail.prod.SDeliveryFee} 원</h4><br />
	<hr />
	<h2>합계 : ${subDetail.sPrice + subDetail.prod.SDeliveryFee} 원</h2>
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>