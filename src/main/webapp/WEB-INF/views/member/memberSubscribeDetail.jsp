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
			    <fmt:parseDate value="${subOrder.SOrderDate}" pattern="yyyy-MM-dd'T'HH:mm" var="orderDate"/>
			    <fmt:formatDate value="${orderDate}" pattern="yyyy-MM-dd"/>
		    </th>
		    <th>${subOrder.SOrderNo}</th>
		    <th>${subOrder.SOrderStatus}</th>
		  </tr>
		</thead>
		<tbody>
		  <tr>
		    <td>정기구독 ${subOrder.STimes}회차</td>
		    <td>${subProduct.SProductName} ${subProduct.SProductInfo}</td>
		    <td>${subOrder.SPrice}원</td>
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
			    <td>${subOrder.SOrderNo}</td>
			    <td></td>
			    <td>
			    	<fmt:parseDate value="${subOrder.SOrderDate}" pattern="yyyy-MM-dd'T'HH:mm" var="orderDate"/>
				    <fmt:formatDate value="${orderDate}" pattern="yyyy-MM-dd"/>
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
			    <td>수령인 : ${subOrder.soRecipient}</td>
			    <td>연락처 : ${subOrder.soPhone}</td>
			    <td><strong>${subOrder.SOrderStatus}</strong></td>
			  </tr>
			  <tr>
			    <td colspan="2">배송지 : ${subOrder.soAddress} ${subOrder.soAddressEx}</td>
			    <td></td>
			  </tr>
			  <tr>
			    <td colspan="2">요청사항 : ${subOrder.soDeliveryRequest}</td>
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
			    <td>결제일자</td>
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
	<h4>구독금액 : ${subOrder.SPrice} 원</h4>
	<h4>배송비 :  ${subProduct.SDeliveryFee} 원</h4><br />
	<hr />
	<h2>합계 : ${subOrder.SPrice + subProduct.SDeliveryFee} 원</h2>
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>