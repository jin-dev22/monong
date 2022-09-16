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
<c:if test="${empty subList}">
	<h3>구독 히스토리가 없습니다.</h3>
</c:if>
<c:if test="${not empty subList}">
	<c:forEach items="${subList}" var="subList">
		<table id="member-subScription-tbl" class="table table-borderless table-striped text-center">
			<thead>
			  <tr>
			    <th class="tg-0pky">
				    <fmt:parseDate value="${subList.SOrderDate}" pattern="yyyy-MM-dd'T'HH:mm" var="orderDate"/>
				    <fmt:formatDate value="${orderDate}" pattern="yyyy-MM-dd"/>
			    </th>
			    <th class="tg-0pky"><a href="${pageContext.request.contextPath}/member/memberSubscribeDetail.do?sOrderNo=${subList.SOrderNo}">${subList.SOrderNo}</a></th>
			    <th class="tg-0pky">${subList.SOrderStatus}</th>
			  </tr>
			</thead>
			<tbody>
			  <tr>
			    <td class="tg-0pky">정기구독 ${subList.STimes}회차</td>
			    <td class="tg-0pky">${subList.soProductCode}</td>
			    <td class="tg-0pky">${subList.SPrice}원</td>
			  </tr>
			</tbody>
		</table>
	</c:forEach>
</c:if>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>